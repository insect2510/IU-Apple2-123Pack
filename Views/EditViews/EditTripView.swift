
//
//  EditTripView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 16.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct EditTripView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var trip: Trip
    
    @Query(sort: [
        SortDescriptor(\Item.category.name),
        SortDescriptor(\Item.name)
    ])
    
    private var items: [Item]

    // MARK: - State

    @State private var name = ""
    @State private var details = ""

    @State private var startDate = Date()
    @State private var endDate = Date()

    @State private var selectedIcon: TripIcon = .holiday

    // Packing List

    @State private var selectedItemIDs: Set<UUID> = []
    @State private var packedItemIDs: Set<UUID> = []
    @State private var quantities: [UUID: Int] = [:]

    @State private var showDeleteConfirmation = false

    // MARK: - Body

    var body: some View {

        Form {

            // MARK: - Trip Information

            Section ("Trip Information") {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Trip Name")
                        .foregroundStyle(.primary)
                    
                    PrimaryTextField(title: "Give it a name", text: $name)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Trip Details")
                        .foregroundStyle(.primary)
                    
                    PrimaryTextField(
                        title: "Enter some details",
                        text: $details
                    )
                    .lineLimit(3...5)
                }
                
            }
            
            // MARK: - Trip Dates
            
            Section ("Trip Dates") {
                DatePicker(
                    "Start Date",
                    selection: $startDate,
                    displayedComponents: .date
                )

                DatePicker(
                    "End Date",
                    selection: $endDate,
                    in: startDate...,
                    displayedComponents: .date
                )
            }

            // MARK: - Trip Icon

            Section("Trip Icon") {

                Picker(
                    "",
                    selection: $selectedIcon
                ) {
                    
                    Text("Trip Icon")

                    ForEach(TripIcon.allCases, id: \.self) { icon in

                        Label(
                            icon.title,
                            systemImage: icon.rawValue
                        )
                        .tag(icon)
                    }
                }
            }

            // MARK: - Added Items

            Section("Added Items") {

                let addedItems = items.filter {
                    selectedItemIDs.contains($0.id)
                }

                if addedItems.isEmpty {

                    Text("No items added yet.")
                        .foregroundStyle(.secondary)

                } else {

                    ForEach(addedItems) { item in
                        addedItemRow(item)
                    }
                }
            }

            // MARK: - Available Items

            Section("Available Items") {

                let availableItems = items.filter {
                    !selectedItemIDs.contains($0.id)
                }

                if availableItems.isEmpty {

                    Text("All items have been added.")
                        .foregroundStyle(.secondary)

                } else {

                    ForEach(availableItems) { item in

                        Button {

                            addItem(item)

                        } label: {

                            HStack(spacing: 12) {

                                Image(systemName: item.category.icon)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 28)

                                VStack(alignment: .leading) {

                                    Text(item.name)
                                        .foregroundStyle(.primary)

                                    Text(item.category.name)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Text("× \(item.defaultQuantity)")
                                    .foregroundStyle(.secondary)

                                Image(systemName: "plus.circle")
                                    .foregroundStyle(Colors.primarycolor)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
        }

        // MARK: - Navigation
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollContentBackground(.hidden)
        .navigationTitle("Edit Trip")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

        
        // MARK: - Toolbar

        .toolbar {
            ToolbarSave(
                cancelAction: {
                    dismiss()
                },
                saveAction: {
                    saveChanges()
                },
                saveDisabled: name.trimmingCharacters(
                    in: .whitespaces
                ).isEmpty
            )
        }
        
        .onAppear {
            loadTrip()
        }
    }

    // MARK: - Load Trip

    private func loadTrip() {

        name = trip.name
        details = trip.details ?? ""

        startDate = trip.startDate

        endDate = max(
            trip.endDate,
            startDate
        )

        selectedIcon = TripIcon(
            rawValue: trip.image ?? ""
        ) ?? .holiday

        selectedItemIDs = Set(
            trip.packingList.map { $0.item.id }
        )

        packedItemIDs = Set(
            trip.packingList
                .filter { $0.isPacked }
                .map { $0.item.id }
        )

        quantities = Dictionary(
            uniqueKeysWithValues: trip.packingList.map {
                ($0.item.id, $0.quantity)
            }
        )
    }

    // MARK: - Added Item Row

    private func addedItemRow(_ item: Item) -> some View {

        HStack(spacing: 12) {

            // Packed Status

            Button {

                togglePacked(item)

            } label: {

                Image(
                    systemName: packedItemIDs.contains(item.id)
                    ? "checkmark.circle.fill"
                    : "circle"
                )
                .font(.system(size: 22))
                .foregroundStyle(
                    packedItemIDs.contains(item.id)
                    ? .green : .secondary
                )
            }
            .buttonStyle(.plain)

            // Item Information

            VStack(alignment: .leading) {

                Text(item.name)
                    .strikethrough(
                        packedItemIDs.contains(item.id)
                    )

                Text(item.category.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            // Quantity

            Stepper(
                "\(quantities[item.id] ?? item.defaultQuantity)",
                value: quantityBinding(for: item),
                in: 1...99
            )
            .fixedSize()

            // Remove Item

            Button(role: .destructive) {

                removeItem(item)

            } label: {

                Image(systemName: "minus.circle")
                    .foregroundStyle(.red)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }

    // MARK: - Add Item

    private func addItem(_ item: Item) {

        selectedItemIDs.insert(item.id)

        quantities[item.id] = item.defaultQuantity
        packedItemIDs.remove(item.id)
    }

    // MARK: - Remove Item

    private func removeItem(_ item: Item) {

        selectedItemIDs.remove(item.id)
        packedItemIDs.remove(item.id)
        quantities.removeValue(forKey: item.id)
    }

    // MARK: - Toggle Packed

    private func togglePacked(_ item: Item) {

        if packedItemIDs.contains(item.id) {
            packedItemIDs.remove(item.id)
        } else {
            packedItemIDs.insert(item.id)
        }
    }

    // MARK: - Quantity Binding

    private func quantityBinding(
        for item: Item
    ) -> Binding<Int> {

        Binding(

            get: {
                quantities[item.id] ?? item.defaultQuantity
            },

            set: {
                quantities[item.id] = $0
            }
        )
    }

    // MARK: - Save Changes

    private func saveChanges() {

        // Trip Information

        trip.name = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        trip.details = details.isEmpty ? nil : details

        trip.startDate = startDate
        trip.endDate = endDate
        trip.image = selectedIcon.rawValue

        // Existing Packing List Entries

        let oldEntries = trip.packingList

        var updatedPackingList: [PackingList] = []

        for itemID in selectedItemIDs {

            guard let item = items.first(where: {
                $0.id == itemID
            }) else {
                continue
            }

            if let existingEntry = oldEntries.first(where: {
                $0.item.id == itemID
            }) {

                existingEntry.quantity = quantities[itemID] ?? 1

                existingEntry.isPacked = packedItemIDs.contains(itemID)

                updatedPackingList.append(existingEntry)

            } else {

                let newEntry = PackingList(
                    item: item,
                    quantity: quantities[itemID] ?? 1,
                    isPacked: packedItemIDs.contains(itemID)
                )

                modelContext.insert(newEntry)

                updatedPackingList.append(newEntry)
            }
        }

        // MARK: - Delete Removed Entries

        for entry in oldEntries {

            if !selectedItemIDs.contains(entry.item.id) {
                modelContext.delete(entry)
            }
        }

        // MARK: - Update Packing List

        trip.packingList = updatedPackingList

        // Save

        do {

            try modelContext.save()
            dismiss()

        } catch {

            print(
                "Error saving trip: \(error.localizedDescription)"
            )
        }
    }
    
}

