
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
    
   // @Query(sort: \Item.name) private var items: [Item]
    
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        
        Form {
            
            // MARK: - Trip Titel
            
            Text(trip.name)
                .font(.title)
                .fontWeight(.bold)
            
            // MARK: - Trip Information
            
            Section() {
                
                
                if let details = trip.details,
                   !details.isEmpty {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Details")
                            .foregroundStyle(.secondary)
                        
                        Text(details)
                    }
                }
                
                if let startDate = trip.startDate {
                    
                    HStack {
                        Text("Start Date:")
                        
                        Spacer()
                        
                        Text(
                            startDate.formatted(
                                date: .abbreviated,
                                time: .omitted
                            )
                        )
                        
                    }
                    
                }
                
                if let endDate = trip.endDate {
                    
                    HStack {
                        
                        Text("End Date:")
                        
                        Spacer()
                        
                        Text(
                            endDate.formatted(
                                date: .abbreviated,
                                time: .omitted
                            )
                        )
                    }
                    
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
                
                PrimaryButton(
                    title: "Delete Trip",
                    icon: NavIcons.trash.rawValue
                ) {
                    showDeleteConfirmation = true
                }
                .disabled(!trip.packingList.isEmpty)
            }
        }
        
        // MARK: - Navigation
        
        .scrollContentBackground(.hidden)
        .background(Colors.backgroundcolor)
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarDetails(
                dismissAction: {
                    dismiss()
                },
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
                ? "checkmark.circle.fill"
                : "circle"
            )
            .font(.system(size: 22))
            .foregroundStyle(
                entry.isPacked ? .green : .secondary
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
