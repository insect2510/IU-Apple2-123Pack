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

    @Query private var items: [Item]
    
    @State private var showAddItemView = false
    

    var body: some View {

        NavigationStack {

            Form {

                // MARK: - Trip Information

                Section("Trip Information") {

                    TextField("Trip Name", text: $trip.name)

                    DatePicker(
                        "Start Date",
                        selection: Binding(
                            get: { trip.startDate ?? Date() },
                            set: { trip.startDate = $0 }
                        ),
                        displayedComponents: .date
                    )

                    DatePicker(
                        "End Date",
                        selection: Binding(
                            get: { trip.endDate ?? trip.startDate ?? Date() },
                            set: { trip.endDate = $0 }
                        ),
                        in: (trip.startDate ?? Date())...,
                        displayedComponents: .date
                    )
                }

                // MARK: - Trip Icon

                Section("Trip Icon") {

                    Picker("Select Icon", selection: Binding(
                        get: {
                            TripIcon(rawValue: trip.image ?? "") ?? .airplane
                        },
                        set: {
                            trip.image = $0.rawValue
                        }
                    )) {

                        ForEach(TripIcon.allCases, id: \.self) { icon in

                            Label(icon.title, systemImage: icon.rawValue)
                                .tag(icon)
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
                        .onDelete(perform: deleteItems)
                    }
                    Button {
                        showAddItemView = true
                    } label: {
                        Label("Add Items", systemImage: "plus.circle")
                    }
                }
            }
            .navigationTitle("Edit Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        do {
                            try modelContext.save()
                            dismiss()
                        } catch {
                            print("Error saving trip: \(error.localizedDescription)")
                        }
                    }
                }
            }
   
            .sheet(isPresented: $showAddItemView) {
                AddItemToTripView(trip: trip)
            }
        }
    }
    
    // MARK: - Packing List Row
    @ViewBuilder
    private func packingListRow(_ entry: PackingList) -> some View {

        if let item = items.first(where: { $0.id == entry.itemID }) {

            HStack(spacing: 12) {

                // MARK: - Packed Checkbox

                Button {
                    entry.isPacked.toggle()
                } label: {
                    Image(systemName: entry.isPacked
                          ? "checkmark.circle.fill"
                          : "circle")
                        .font(.system(size: 22))
                        .foregroundStyle(
                            entry.isPacked ? .green : .secondary
                        )
                }
                .buttonStyle(.plain)

                // MARK: - Item Information

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

                // MARK: - Quantity

                Stepper(
                    "\(entry.quantity)",
                    value: quantityBinding(for: entry),
                    in: 1...99
                )
                .fixedSize()
            }
        }
    }

    
    private func quantityBinding(for entry: PackingList) -> Binding<Int> {

        Binding(
            get: { entry.quantity },
            set: { entry.quantity = $0 }
        )
    }
    
    //MARK: Delete Items
    
    private func deleteItems(at offsets: IndexSet) {

        for index in offsets.sorted(by: >) {
            let entry = trip.packingList[index]

            trip.packingList.remove(at: index)
            modelContext.delete(entry)
        }
    }
}
