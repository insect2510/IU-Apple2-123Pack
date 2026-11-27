
//
//  NewTripView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 03.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct NewTripView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \Item.name) private var items: [Item]

    // MARK: - Properties

    @State private var name = ""
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(
        byAdding: .day,
        value: 1,
        to: Date()
    ) ?? Date()
    @State private var details = ""
    @State private var selectedIcon: TripIcon = TripIcon.allCases.first ?? .holiday

    // MARK: - Item Selection

    @State private var selectedItemIDs: Set<PersistentIdentifier> = []

    // MARK: - Body

    var body: some View {

            Form {

                // MARK: - Trip Information

                Section("Trip Information"){
                    
                    
                    // MARK: Trip Name
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Trip Name:")
                            .foregroundStyle(.primary)
                        
                        PrimaryTextField(title: "No trip without a name", text: $name)
                    }
                    
                    // MARK: Trip Details
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Trip Details:")
                            .foregroundStyle(.primary)
                        
                        PrimaryTextField(
                            title: "Enter some details",
                            text: $details
                        )
                        .lineLimit(3...5)
                    }
                }
                
                // MARK: Trip Dates
                
                Section("Trip Dates"){

                    // Trip Start Date
                    
                    DatePicker(
                        "Start Date:",
                        selection: $startDate,
                        displayedComponents: .date
                    )

                    // Trip End Date
                    
                    DatePicker(
                        "End Date:",
                        selection: $endDate,
                        in: startDate...,
                        displayedComponents: .date
                    )
                    
                }

                // MARK: - Trip Icon

                Section("Trip Icon") {
                    
                    VStack(alignment: .leading, spacing: 8) {

                        Picker("", selection: $selectedIcon
                        ) {

                            ForEach(TripIcon.allCases, id: \.self) { icon in
                                
                                Label(
                                    icon.title,
                                    systemImage: icon.rawValue
                                )
                                .tag(icon)
                            }
                        }
                        .pickerStyle(.menu)
                        .labelsHidden()
                        .tint(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(12)
                        .background(Colors.backgroundcolor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(.quaternary, lineWidth: 1)
                        }
                    }
                }

                // MARK: - Packing List

                Section {

                    if items.isEmpty {

                        Text("No items available.")
                            .foregroundStyle(.secondary)

                    } else {

                        ForEach(items) { item in

                            Button {

                                toggleItem(item)

                            } label: {

                                HStack {

                                    Image(systemName: item.category.icon)
                                        .foregroundStyle(.secondary)
                                        .frame(width: 28)

                                    Text(item.name)
                                        .foregroundStyle(.primary)

                                    Spacer()

                                    Text("× \(item.defaultQuantity)")
                                        .foregroundStyle(.secondary)
                                    
                                    // toggle button icon

                                    Image(
                                        systemName: selectedItemIDs.contains(item.persistentModelID)
                                        ? NavIcons.checkmark.rawValue
                                        : NavIcons.circle.rawValue
                                    )
                                    .foregroundStyle(
                                        selectedItemIDs.contains(item.persistentModelID)
                                        ? Colors.primarycolor
                                        : .secondary
                                    )
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }

                } header: {

                    HStack {
                        Text("Packing List")
                        Spacer()
                        Text("\(selectedItemIDs.count) selected")
                    }

                } footer: {

                    Text("Select the items you want to add to your trip.")
                }
            }
            
            // MARK: - Navigation
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
            .navigationTitle("New Trip")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)

            // MARK: - Toolbar

            .toolbar {
                ToolbarSave(
                    cancelAction: {
                        dismiss()
                    },
                    saveAction: {
                        createTrip()
                    },
                    saveDisabled: name.trimmingCharacters(
                        in: .whitespaces
                    ).isEmpty
                )
            }
    }

    // MARK: - Toggle Item

    private func toggleItem(_ item: Item) {

        let id = item.persistentModelID

        if selectedItemIDs.contains(id) {
            selectedItemIDs.remove(id)
        } else {
            selectedItemIDs.insert(id)
        }
    }

    // MARK: - Create Trip

    private func createTrip() {

        // Get selected items

        let selectedItems = items.filter {
            selectedItemIDs.contains($0.persistentModelID)
        }

        // Create Packing List

        let packingList = selectedItems.map { item in

            PackingList(
                item: item,
                quantity: item.defaultQuantity,
                isPacked: false
            )
        }

        // Create Trip

        let newTrip = Trip(
            name: name,
            details: details.isEmpty ? nil : details,
            startDate: startDate,
            endDate: endDate,
            image: selectedIcon.rawValue,
            packingList: packingList
        )

        modelContext.insert(newTrip)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error creating trip: \(error.localizedDescription)")
        }
    }
}

#Preview {
    NewTripView()

}
