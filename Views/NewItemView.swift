//
//  NewItemView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 02.11.26.
//

import Foundation

import SwiftUI
import SwiftData

struct NewItemView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query private var categories: [Category]

    @State private var name = ""
    @State private var details = ""
    @State private var defaultQuantity = 1
    @State private var isAutoAdd = false
    @State private var selectedCategoryID: UUID?
    @State private var showNewCategoryView = false

    var body: some View {

        NavigationStack {

            Form {

                Section("Item Information") {

                    TextField("Item Name", text: $name)

                    TextField("Details", text: $details)

                    Stepper(
                        "Default Quantity: \(defaultQuantity)",
                        value: $defaultQuantity,
                        in: 1...99
                    )
                }

                Section("Category") {

                    Picker("Select Category", selection: $selectedCategoryID) {

                        Text("Select Category")
                            .tag(nil as UUID?)

                        ForEach(categories) { category in
                            Text(category.name)
                                .tag(category.id as UUID?)
                        }
                    }

                    Button {
                        showNewCategoryView = true
                    } label: {
                        Label("Create New Category", systemImage: "plus.circle")
                    }
                }

                Section("Settings") {

                    Toggle(
                        "Automatically add to every trip",
                        isOn: $isAutoAdd
                    )
                }

                Section {

                    Button("Save Item") {
                        saveItem()
                    }
                    .disabled(name.isEmpty || selectedCategoryID == nil)
                }
            }
            .navigationTitle("New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showNewCategoryView) {
                NewCategoryView { category in
                    selectedCategoryID = category.id
                }
            }
        }
    }

    // MARK: Save Item

    private func saveItem() {

        guard let category = categories.first(where: {
            $0.id == selectedCategoryID
        }) else {
            return
        }

        let newItem = Item(
            name: name,
            defaultQuantity: defaultQuantity,
            details: details.isEmpty ? nil : details,
            isAutoAdd: isAutoAdd,
            category: category
        )

        modelContext.insert(newItem)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error saving item: \(error)")
        }
    }
}
