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

    @State private var selectedIcon = "airplane"

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

                        Label("Airplane", systemImage: "airplane")
                            .tag("airplane")

                        Label("Car", systemImage: "car")
                            .tag("car")

                        Label("Train", systemImage: "tram")
                            .tag("tram")

                        Label("Hiking", systemImage: "figure.hiking")
                            .tag("figure.hiking")

                        Label("Camping", systemImage: "tent")
                            .tag("tent")

                        Label("Sailboat", systemImage: "sailboat")
                            .tag("sailboat")
                    }
                }

                // MARK: - Auto Add Items

                Section("Packing List") {

                    HStack {
                        Text("Automatic Items")

                        Spacer()

                        Text("\(items.filter { $0.isAutoAdd }.count)")
                            .foregroundStyle(.secondary)
                    }

                    Text("All items marked as automatic will be added to your packing list.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("New Trip")
            .navigationBarTitleDisplayMode(.inline)

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
            image: selectedIcon,
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
