
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

    @State private var selectedIcon: TripIcon = .airplane

    // MARK: - Item Selection

    @State private var selectedItemIDs: Set<PersistentIdentifier> = []

    // MARK: - Body

    var body: some View {

            Form {

                // MARK: - Trip Information

                Section("Trip Information") {
                    
                    
                    // Trip Name

                    TextField("Trip Name", text: $name)

                    // Trip Start Date
                    
                    DatePicker(
                        "Start Date",
                        selection: $startDate,
                        displayedComponents: .date
                    )

                    // Trip End Date
                    
                    DatePicker(
                        "End Date",
                        selection: $endDate,
                        in: startDate...,
                        displayedComponents: .date
                    )
                    
                    // Trip Details
                    
                    TextField(
                        "Description",
                        text: $details,
                        axis: .vertical
                    )
                    .lineLimit(3...5)
                }

                // MARK: - Trip Icon

                Section("Trip Icon") {

                    Picker("Select Icon", selection: $selectedIcon) {

                        ForEach(TripIcon.allCases, id: \.self) { icon in

                            HStack(spacing: 10) {
                                Image(systemName: icon.rawValue)
                                Text(icon.title)
                            }
                            .tag(icon)
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

                                    Image(
                                        systemName: selectedItemIDs.contains(item.persistentModelID)
                                        ? "checkmark.circle.fill"
                                        : "circle"
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
            
            .navigationTitle("New Trip")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)

            // MARK: - Toolbar

            .toolbar {
                ToolbarEdit(
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
                itemID: item.id,
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
