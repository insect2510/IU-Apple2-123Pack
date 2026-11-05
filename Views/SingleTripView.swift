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
    @Query private var items: [Item]

    @Bindable var trip: Trip

    var body: some View {

        NavigationStack {

            Form {

                // MARK: - Trip Information

                Section("Trip Information") {

                    Text(trip.name)

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

                // MARK: - Packing List

                Section("Packing List") {

                    if trip.packingList.isEmpty {

                        Text("No items added yet.")
                            .foregroundStyle(.secondary)

                    } else {

                        ForEach(trip.packingList) { entry in

                            if let item = items.first(where: { $0.id == entry.itemID }) {

                                HStack {

                                    Image(systemName: item.category.icon)
                                        .foregroundStyle(.secondary)
                                        .frame(width: 28)

                                    VStack(alignment: .leading) {
                                        Text(item.name)

                                        Text(item.category.name)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }

                                    Spacer()

                                    Text("× \(entry.quantity)")
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Trip Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
