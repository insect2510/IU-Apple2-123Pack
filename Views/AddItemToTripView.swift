//
//  AddItemToTripView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 05.11.26.
//
import Foundation
import SwiftUI
import SwiftData

struct AddItemToTripView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query private var items: [Item]

    @Bindable var trip: Trip

    var availableItems: [Item] {
        items.filter { item in
            !trip.packingList.contains {
                $0.itemID == item.id
            }
        }
    }

    var body: some View {

        NavigationStack {

            List {

                if availableItems.isEmpty {

                    Text("No more items available.")
                        .foregroundStyle(.secondary)

                } else {

                    ForEach(availableItems) { item in

                        Button {
                            addItem(item)
                        } label: {

                            HStack {

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
                                    .foregroundStyle(.blue)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle("Add Items")
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

    // MARK: - Add Item

    private func addItem(_ item: Item) {

        let newEntry = PackingList(
            itemID: item.id,
            quantity: item.defaultQuantity
        )

        trip.packingList.append(newEntry)

        modelContext.insert(newEntry)
    }
}
