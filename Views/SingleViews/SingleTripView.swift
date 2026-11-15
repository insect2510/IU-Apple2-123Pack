
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

    @Query(sort: \Item.name) private var items: [Item]

    // MARK: - State

    @State private var isEditing = false
    
    @State private var showDeleteConfirmation = false

    // Trip Information

    @State private var name = ""
    @State private var details = ""

    @State private var startDate = Date()
    @State private var endDate = Date()

    @State private var selectedIcon: TripIcon = .airplane

    // Packing List

    @State private var selectedItemIDs: Set<UUID> = []
    @State private var packedItemIDs: Set<UUID> = []
    @State private var quantities: [UUID: Int] = [:]

    // MARK: - Body

    var body: some View {

        NavigationStack {

            Form {

                // MARK: - Trip Information

                Section("Trip Information") {

                    if isEditing {

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

                    } else {

                        LabeledContent("Trip Name") {
                            Text(trip.name)
                        }

                        if let details = trip.details,
                           !details.isEmpty {

                            VStack(alignment: .leading, spacing: 8) {

                                Text("Details")
                                    .foregroundStyle(.secondary)

                                Text(details)
                            }
                        }

                        if let startDate = trip.startDate {

                            LabeledContent("Start Date") {
                                Text(startDate.formatted(date: .abbreviated, time: .omitted))
                            }
                        }

                        if let endDate = trip.endDate {

                            LabeledContent("End Date") {
                                Text(endDate.formatted(date: .abbreviated, time: .omitted))
                            }
                        }
                    }
                }

                // MARK: - Trip Icon

                Section("Trip Icon") {

                    if isEditing {

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

                    } else {

                        HStack(spacing: 12) {

                            Image(systemName: trip.image ?? "airplane")
                                .font(.title2)

                            Text(
                                TripIcon(rawValue: trip.image ?? "")?.title ?? "Trip"
                            )
                        }
                    }
                }

                // MARK: - Packing List

                if isEditing {

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

                } else {

                    // MARK: - Display Packing List

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
                }
                
                // MARK: Save Button

                if isEditing {

                    Section {
                        
                        SecondaryButton(
                            title: "Save Changes",
                            icon: "checkmark"
                        ) {
                            saveChanges()
                        }
                        .disabled(
                            name.trimmingCharacters(
                                in: .whitespacesAndNewlines
                            ).isEmpty
                        )
                    }
                }
                    
            }

            // MARK: - Navigation

            .navigationTitle(trip.name)
            .navigationBarTitleDisplayMode(.inline)

            // MARK: - Toolbar

            .toolbar {

                ToolbarItem(placement: .confirmationAction) {

                    if isEditing {
                        
                        Button("Cancel") {
                            cancelEditing()
                        }

                    } else {

                        Button("Edit") {
                            startEditing()
                        }
                    }
                }
                
                ToolbarItem(placement: .destructiveAction) {

                    if isEditing {

                        Button(role: .destructive) {
                            showDeleteConfirmation = true
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
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
                Text("Are you sure you want to delete this trip? This action cannot be undone.")
            }
        }
    }

    // MARK: - Display Packing List Row

    private func packingListRow(_ entry: PackingList) -> some View {

        if let item = items.first(where: { $0.id == entry.itemID }) {

            return AnyView(

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

                        Text(item.name)
                            .strikethrough(entry.isPacked)
                            .foregroundStyle(
                                entry.isPacked ? .secondary : .primary
                            )

                        Text(item.category.name)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Text("× \(entry.quantity)")
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            )
        }

        return AnyView(EmptyView())
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
                    packedItemIDs.contains(item.id) ? .green : .secondary
                )
            }
            .buttonStyle(.plain)

            // Item Information

            VStack(alignment: .leading) {

                Text(item.name)
                    .strikethrough(packedItemIDs.contains(item.id))

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

    // MARK: - Start Editing

    private func startEditing() {

        name = trip.name
        details = trip.details ?? ""

        startDate = trip.startDate ?? Date()

        endDate = max(
            trip.endDate ?? Date(),
            startDate
        )

        selectedIcon = TripIcon(
            rawValue: trip.image ?? ""
        ) ?? .airplane

        selectedItemIDs = Set(
            trip.packingList.map { $0.itemID }
        )

        packedItemIDs = Set(
            trip.packingList
                .filter { $0.isPacked }
                .map { $0.itemID }
        )

        quantities = Dictionary(
            uniqueKeysWithValues: trip.packingList.map {
                ($0.itemID, $0.quantity)
            }
        )

        isEditing = true
    }

    // MARK: - Cancel Editing

    private func cancelEditing() {

        isEditing = false
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

    // MARK: - Save Changes

    private func saveChanges() {

        // Trip Information

        trip.name = name.trimmingCharacters(in: .whitespaces)
        trip.details = details.isEmpty ? nil : details

        trip.startDate = startDate
        trip.endDate = endDate
        trip.image = selectedIcon.rawValue

        // Existing Packing List Entries

        let oldEntries = trip.packingList

        var updatedPackingList: [PackingList] = []

        for itemID in selectedItemIDs {

            if let existingEntry = oldEntries.first(where: {
                $0.itemID == itemID
            }) {

                existingEntry.quantity = quantities[itemID] ?? 1
                existingEntry.isPacked = packedItemIDs.contains(itemID)

                updatedPackingList.append(existingEntry)

            } else {

                let newEntry = PackingList(
                    itemID: itemID,
                    quantity: quantities[itemID] ?? 1,
                    isPacked: packedItemIDs.contains(itemID)
                )

                updatedPackingList.append(newEntry)
            }
        }

        // Delete Removed Entries

        for entry in oldEntries {

            if !selectedItemIDs.contains(entry.itemID) {
                modelContext.delete(entry)
            }
        }

        // Update Packing List

        trip.packingList = updatedPackingList

        // Save

        do {

            try modelContext.save()
            isEditing = false

        } catch {

            print(
                "Error saving trip: \(error.localizedDescription)"
            )
        }
    }
    
    
    // MARK: - Delete Trip

    private func deleteTrip() {

        modelContext.delete(trip)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error deleting trip: \(error.localizedDescription)")
        }
    }
}
