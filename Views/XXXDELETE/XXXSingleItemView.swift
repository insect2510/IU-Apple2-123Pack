//
//  SingleItemView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 07.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct SingleItemView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var item: Item

    @Query(sort: \Category.name) private var categories: [Category]

    var body: some View {

        Form {

            // MARK: - Item Information

            Section("Item Information") {

                TextField("Item Name", text: $item.name)

                Picker("Category", selection: $item.category) {

                    ForEach(categories) { category in

                        Text(category.name)
                            .tag(category)
                    }
                }

                Stepper(
                    "Default Quantity: \(item.defaultQuantity)",
                    value: $item.defaultQuantity,
                    in: 1...99
                )

                VStack(alignment: .leading, spacing: 8) {

                    Text("Details")
                        .foregroundStyle(.secondary)

                    TextField(
                        "Item Details",
                        text: Binding(
                            get: { item.details ?? "" },
                            set: { item.details = $0 }
                        ),
                        axis: .vertical
                    )
                    .lineLimit(3...5)
                }
            }

            // MARK: - Settings

            Section("Settings") {

                Toggle(
                    "Automatic Add",
                    isOn: $item.isAutoAdd
                )
            }
        }
        .navigationTitle("Edit Item")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .confirmationAction) {

                Button("Done") {

                    do {
                        try modelContext.save()
                        dismiss()
                    } catch {
                        print("Error saving item: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
