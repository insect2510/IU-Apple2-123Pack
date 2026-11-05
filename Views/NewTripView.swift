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

    @Query private var items: [Item]

    // MARK: - Properties

    @State private var name = ""
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(
        byAdding: .day,
        value: 7,
        to: Date()
    ) ?? Date()

    @State private var selectedIcon: TripIcon = .airplane

    // MARK: - Body

    var body: some View {

        NavigationStack {

            Form {

                // MARK: - Trip Information

                Section("Trip Information") {

                    TextField("Trip Name", text: $name)

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

                    Picker("Select Icon", selection: $selectedIcon) {

                        ForEach(TripIcon.allCases, id: \.self) { icon in

                            HStack {
                                Image(systemName: icon.rawValue)
                                Text(icon.title)
                            }
                            .tag(icon)
                        }
                    }
                }

                // MARK: - Auto Add Items

                Section("Packing List") {

                    let automaticItems = items.filter { $0.isAutoAdd }

                    if automaticItems.isEmpty {

                        Text("No automatic items selected.")
                            .foregroundStyle(.secondary)

                    } else {

                        ForEach(automaticItems) { item in

                            HStack {

                                Image(systemName: item.category.icon)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 28)

                                Text(item.name)

                                Spacer()

                                Text("× \(item.defaultQuantity)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }

                    Text("These items will automatically be added to your packing list.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

            }
                
            // MARK: - Toolbar

            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        createTrip()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    // MARK: - Create Trip

    private func createTrip() {

        // Automatic Packing List Items

        let packingList = items
            .filter { $0.isAutoAdd }
            .map { item in
                PackingList(
                    itemID: item.id,
                    quantity: item.defaultQuantity
                )
            }

        // Create Trip

        let newTrip = Trip(
            name: name,
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
