//
//  SingleItemView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 17.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct DetailItemView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let item: Item
    
    @State private var showDeleteConfirmation = false
    @State private var showEditItem = false
    
    @Query private var trips: [Trip]
    
    // MARK: - Assigned Trips
    
    private var assignedTrips: [Trip] {
        trips.filter { trip in
            trip.packingList.contains { $0.item.id == item.id }
        }
        .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
    }
    
    var body: some View {
        
        List {
            
            // MARK: - Item Header
            
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(spacing: 16) {
                    
                    Image(systemName: item.category.icon)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(.primary)
                        .frame(width: 68, height: 68)
                        .background(
                            Colors.cardbackgroundcolor,
                            in: RoundedRectangle(cornerRadius: 16)
                        )
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(item.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(item.category.name)
                    }
                }
            }
            
            // MARK: - Item Information
            
            Section {
                
                // MARK: - Default Quantity
                
                HStack {
                    
                    Text("Default Quantity:")
                    
                    Spacer()
                    
                    Text("\(item.defaultQuantity)")
                    
                }
                
            }
            
            
            // MARK: - Details
            
            Section("Details") {
                
                if let details = item.details, !details.isEmpty {
                    
                    Text(details)
                    
                } else {
                    
                    // in case there are no details entered
                    
                    Text("No Details.")
                        .foregroundStyle(.secondary)
                    
                }
            }
            
            
            // MARK: - Assigned Trips
            
            Section("Trips (\(assignedTrips.count))") {
                
                if assignedTrips.isEmpty {
                    
                    Text("This item is not assigned to any trip.")
                        .foregroundStyle(.secondary)
                    
                } else {
                    
                    ForEach(assignedTrips) { trip in
                        
                        NavigationLink {
                            SingleTripView(trip: trip)
                        } label: {
                            
                            HStack(spacing: 12) {
                                
                                Image(systemName: trip.image)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 28)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text(trip.name)
                                        .font(.headline)
                                    
                                }
                                
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            
            // MARK: - Edit or Delete Item
            
            Section {
                
                HStack {
                    
                    PrimaryButton(
                        title: "Edit item",
                        icon: NavIcons.edit.rawValue
                    ) {
                        showEditItem = true
                    }
                    
                    Spacer()
                    
                    PrimaryButton(
                        title: "Delete Item",
                        icon: NavIcons.trash.rawValue
                    ) {
                        showDeleteConfirmation = true
                    }
                    .disabled(!assignedTrips.isEmpty)
                    
                    
                }
                .listRowBackground(Color.clear)
            }
            
        }
        
        // MARK: - Navigation
        
        .scrollContentBackground(.hidden)
        .background(Colors.backgroundcolor)
        .navigationTitle("Item Detail")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showEditItem) {
            EditItemView(item: item)
        }
        .toolbar {
            ToolbarEdit(
                dismissAction: {
                    dismiss()
                },
                editDestination: AnyView(
                    EditItemView(item: item)
                )
            )
        }
        
        // MARK: - Delete Dialog
        
        .confirmationDialog(
            "Delete Item?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            
            Button("Delete Item", role: .destructive) {
                deleteItem()
            }
            
            Button("Cancel", role: .cancel) {}
            
        } message: {
            
            Text("Are you sure you want to delete this item?")
        }
    }
    
    // MARK: - Delete Trip
    
    private func deleteItem() {
        
        // Alle Packlisten-Einträge dieses Items finden und löschen
        
        for trip in trips {
            
            let entriesToDelete = trip.packingList.filter {
                $0.item == item
            }
            
            for entry in entriesToDelete {
                trip.packingList.removeAll {
                    $0.persistentModelID == entry.persistentModelID
                }
                
                modelContext.delete(entry)
            }
        }
        
        // Anschließend das eigentliche Item löschen
        modelContext.delete(item)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
    }
}
