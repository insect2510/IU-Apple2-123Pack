
//
//  SingleTripView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 05.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct SingleTripView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var trip: Trip
    
    @State private var showDeleteConfirmation = false
    @State private var showEditTrip = false
    
    
    var body: some View {
        
        List {
            
            // MARK: - Trip Header
            
            VStack(alignment: .leading, spacing: 16) {
                
                HStack(spacing: 16) {
                    
                    Image(systemName: trip.image)
                        .font(.system(size: 32, weight: .medium))
                        .foregroundStyle(.primary)
                        .frame(width: 68, height: 68)
                        .background(
                            Colors.cardbackgroundcolor,
                            in: RoundedRectangle(cornerRadius: 16)
                        )
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(trip.name)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
            
            // MARK: - Trip Details
            
            Section("Details") {
                
                if let details = trip.details, !details.isEmpty {
                    
                    Text(details)
                    
                } else {
                    
                    // in case there are no details entered
                    
                    Text("No Details.")
                        .foregroundStyle(.secondary)
                    
                }
            }
            
            // MARK: - Trip Information
            
            Section("Dates") {
                
                // MARK: - Trip Dates
                
                HStack {
                    Text("Start Date:")
                    
                    Spacer()
                    
                    Text(
                        trip.startDate.formatted(
                            date: .abbreviated,
                            time: .omitted
                        )
                    )
                }
                
                HStack {
                    
                    Text("End Date:")
                    
                    Spacer()
                    
                    Text(
                        trip.endDate.formatted(
                            date: .abbreviated,
                            time: .omitted
                        )
                    )
                }
            }
            
            // MARK: - Packing List
            
            Section("Packing List") {
                
                if trip.packingList.isEmpty {
                    
                    Text("No items added yet.")
                        .foregroundStyle(.secondary)
                    
                } else {
                    
                    ForEach(trip.packingList) { entry in
                        packingListRow(entry)
                    }
                }
            }
            
            
            // MARK: - Delete Trip
            
            Section {
                
                HStack {
                    
                    PrimaryButton(
                        title: "Edit Trip",
                        icon: NavIcons.edit.rawValue
                    ) {
                        showEditTrip = true
                    }
                    
                    Spacer()
                    
                    PrimaryButton(
                        title: "Delete Trip",
                        icon: NavIcons.trash.rawValue
                    ) {
                        showDeleteConfirmation = true
                    }
                    .disabled(!trip.packingList.isEmpty)
                    
                }
                .listRowBackground(Color.clear)
            }
            
        }
        
        
        // MARK: - Navigation
        
        .scrollContentBackground(.hidden)
        .background(Colors.backgroundcolor)
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showEditTrip) {
            EditTripView(trip: trip)
        }
        .toolbar {
            ToolbarEdit(
                dismissAction: {
                    dismiss()
                }
                ,
                
                editDestination: AnyView(
                    EditTripView(trip: trip)
                )
            )
        }
        
        // MARK: - Delete Dialog
        
        .confirmationDialog(
            "Delete Trip?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            
            Button("Delete Trip", role: .destructive) {
                deleteTrip()
            }
            
            Button("Cancel", role: .cancel) {}
            
        } message: {
            
            Text("Are you sure you want to delete this trip?")
        }
        
    }
    
    // MARK: - Packing List Row
    
    @ViewBuilder
    private func packingListRow(_ entry: PackingList) -> some View {
        
        HStack(spacing: 12) {
            
            Image(
                systemName: entry.isPacked
                ? NavIcons.checkmark.rawValue
                : NavIcons.circle.rawValue
            )
            .font(.system(size: 22))
            .foregroundStyle(
                entry.isPacked ? Colors.primarycolor : .secondary
            )
            
            VStack(alignment: .leading) {
                
                Text(entry.item.name)
                    .strikethrough(entry.isPacked)
                    .foregroundStyle(
                        entry.isPacked ? .secondary : .primary
                    )
                
                HStack (spacing: 4) {
                    Image(systemName: entry.item.category.icon)
                    Text(entry.item.category.name)
                    
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
            }
            
            Spacer()
            
            Text("× \(entry.quantity)")
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    // MARK: - Delete Trip
    
    private func deleteTrip() {
        
        modelContext.delete(trip)
        
        do {
            
            try modelContext.save()
            dismiss()
            
            
        } catch {
            
            print(
                "Error deleting trip: \(error.localizedDescription)"
            )
        }
    }
    
}
