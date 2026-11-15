//
//  TripView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 15.11.26.
//


import Foundation
import SwiftUI
import SwiftData

struct XXXTripView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \Item.name) private var items: [Item]

    // MARK: - Trip

    let trip: Trip?

    private var isEditing: Bool {
        trip != nil
    }

    // MARK: - Trip Properties

    @State private var name = ""
    @State private var details = ""

    @State private var startDate = Date()

    @State private var endDate = Calendar.current.date(
        byAdding: .day,
        value: 7,
        to: Date()
    ) ?? Date()

    @State private var selectedIcon: TripIcon = .airplane

    // MARK: - Packing List

    @State private var selectedItemIDs: Set<UUID> = []
    @State private var packedItemIDs: Set<UUID> = []
    @State private var quantities: [UUID: Int] = [:]

    // MARK: - Initializer

    init(trip: Trip? = nil) {

        self.trip = trip

        _name = State(initialValue: trip?.name ?? "")
        _details = State(initialValue: trip?.details ?? "")

        _startDate = State(
            initialValue: trip?.startDate ?? Date()
        )

        _endDate = State(
            initialValue: trip?.endDate ??
            Calendar.current.date(
                byAdding: .day,
                value: 7,
                to: Date()
            ) ?? Date()
        )

        _selectedIcon = State(
            initialValue: TripIcon(
                rawValue: trip?.image ?? ""
            ) ?? .airplane
        )

        _selectedItemIDs = State(
            initialValue: Set(
                trip?.packingList.map { $0.itemID } ?? []
            )
        )

        _packedItemIDs = State(
            initialValue: Set(
                trip?.packingList
                    .filter { $0.isPacked }
                    .map { $0.itemID } ?? []
            )
        )

        _quantities = State(
            initialValue: Dictionary(
                uniqueKeysWithValues:
                    (trip?.packingList ?? []).map {
                        ($0.itemID, $0.quantity)
                    }
            )
        )
    }

    // MARK: - Body

    var body: some View {

        NavigationStack {

            Form {

                // MARK: - Trip Information

                Section("Trip Information") {

                    TextField("Trip Name", text: $name)

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Details")
                            .foregroundStyle(.secondary)

                        TextField(
                            "Trip Details",
                            text: $details,
                            axis: .vertical
                        )
                        .lineLimit(3...5)
                    }

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
                        "Select Icon",
                        selection: $selectedIcon
                    ) {

                        ForEach(TripIcon.allCases, id: \.self) { icon in

                            Label(
                                icon.title,
                                systemImage: icon.rawValue
                            )
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

                            packingListRow(item)
                        }
                    }

                } header: {

                    HStack {
                        Text("Packing List")

                        Spacer()

                        Text("\(selectedItemIDs.count) selected")
                    }

                } footer: {

                    Text(
                        "Select the items you want to add to your trip."
                    )
                }
            }

            // MARK: - Navigation

            .navigationTitle(
                isEditing ? "Edit Trip" : "New Trip"
            )
            .navigationBarTitleDisplayMode(.inline)

            // MARK: - Toolbar

            .toolbar {

                ToolbarItem(placement: .cancellationAction) {

                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {

                    Button(isEditing ? "Save" : "Create") {
                        saveTrip()
                    }
                    .disabled(
                        name.trimmingCharacters(
                            in: .whitespaces
                        ).isEmpty
                    )
                }
            }
        }
    }

    // MARK: - Packing List Row

    @ViewBuilder
    private func packingListRow(_ item: Item) -> some View {

        let isSelected = selectedItemIDs.contains(item.id)

        HStack(spacing: 12) {

            // MARK: Item Selection

            if !isEditing {

                Button {

                    toggleItem(item)

                } label: {

                    Image(
                        systemName: isSelected
                        ? "checkmark.circle.fill"
                        : "circle"
                    )
                    .font(.system(size: 22))
                    .foregroundStyle(
                        isSelected
                        ? Colors.primarycolor
                        : .secondary
                    )
                }
                .buttonStyle(.plain)

            } else {

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 22))
                    .foregroundStyle(.secondary)
            }

            // MARK: Item Information

            VStack(alignment: .leading, spacing: 4) {

                Text(item.name)
                    .foregroundStyle(.primary)

                Text(item.category.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            // MARK: Packing Status and Quantity

            if isSelected {

                Button {

                    togglePacked(item)

                } label: {

                    Image(
                        systemName: packedItemIDs.contains(item.id)
                        ? "checkmark.circle.fill"
                        : "circle"
                    )
                    .font(.system(size: 20))
                    .foregroundStyle(
                        packedItemIDs.contains(item.id)
                        ? .green
                        : .secondary
                    )
                }
                .buttonStyle(.plain)

                Stepper(
                    "\(quantities[item.id] ?? item.defaultQuantity)",
                    value: quantityBinding(for: item),
                    in: 1...99
                )
                .fixedSize()
            }
        }
        .padding(.vertical, 4)
    }

    // MARK: - Toggle Item

    private func toggleItem(_ item: Item) {

        if selectedItemIDs.contains(item.id) {

            selectedItemIDs.remove(item.id)
            packedItemIDs.remove(item.id)

        } else {

            selectedItemIDs.insert(item.id)

            quantities[item.id] = quantities[item.id]
                ?? item.defaultQuantity
        }
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

    private func quantityBinding(for item: Item) -> Binding<Int> {

        Binding(
            get: {
                quantities[item.id] ?? item.defaultQuantity
            },
            set: {
                quantities[item.id] = $0
            }
        )
    }

    // MARK: - Save Trip

    private func saveTrip() {

        let trimmedName = name.trimmingCharacters(
            in: .whitespaces
        )

        let selectedItems = items.filter {
            selectedItemIDs.contains($0.id)
        }

        if let trip = trip {

            // MARK: Update Existing Trip

            trip.name = trimmedName
            trip.details = details.isEmpty ? nil : details
            trip.startDate = startDate
            trip.endDate = endDate
            trip.image = selectedIcon.rawValue

            let oldEntries = trip.packingList

            var updatedPackingList: [PackingList] = []

            for item in selectedItems {

                if let existingEntry = oldEntries.first(
                    where: { $0.itemID == item.id }
                ) {

                    // Keep existing entry

                    existingEntry.quantity =
                        quantities[item.id] ?? item.defaultQuantity

                    existingEntry.isPacked =
                        packedItemIDs.contains(item.id)

                    updatedPackingList.append(existingEntry)

                } else {

                    // Create new entry

                    let newEntry = PackingList(
                        itemID: item.id,
                        quantity: quantities[item.id]
                            ?? item.defaultQuantity,
                        isPacked: packedItemIDs.contains(item.id)
                    )

                    updatedPackingList.append(newEntry)
                }
            }

            // Delete removed entries

            for entry in oldEntries {

                if !selectedItemIDs.contains(entry.itemID) {
                    modelContext.delete(entry)
                }
            }

            trip.packingList = updatedPackingList

        } else {

            // MARK: Create New Trip

            let packingList = selectedItems.map { item in

                PackingList(
                    itemID: item.id,
                    quantity: quantities[item.id]
                        ?? item.defaultQuantity,
                    isPacked: false
                )
            }

            let newTrip = Trip(
                name: trimmedName,
                details: details.isEmpty ? nil : details,
                startDate: startDate,
                endDate: endDate,
                image: selectedIcon.rawValue,
                packingList: packingList
            )

            modelContext.insert(newTrip)
        }

        // MARK: Save Context

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
