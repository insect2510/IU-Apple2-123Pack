
//
//  ItemView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 15.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct ItemView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let item: Item?

    @Query(sort: \Category.name) private var categories: [Category]

    // MARK: - Form Properties

    @State private var name: String
    @State private var details: String
    @State private var defaultQuantity: Int
    @State private var isAutoAdd: Bool
    @State private var selectedCategoryID: UUID?

    @State private var isEditing: Bool
    @State private var showNewCategoryView = false

    // MARK: - Initializer

    init(item: Item? = nil) {

        self.item = item

        _name = State(initialValue: item?.name ?? "")
        _details = State(initialValue: item?.details ?? "")
        _defaultQuantity = State(initialValue: item?.defaultQuantity ?? 1)
        _isAutoAdd = State(initialValue: item?.isAutoAdd ?? false)
        _selectedCategoryID = State(initialValue: item?.category.id)

        // New item starts in edit mode
        _isEditing = State(initialValue: item == nil)
    }

    // MARK: - Body

    var body: some View {

        Form {

            // MARK: Item Information

            Section("Item Information") {

                if isEditing {

                    TextField("Item Name", text: $name)

                    Stepper(
                        "Default Quantity: \(defaultQuantity)",
                        value: $defaultQuantity,
                        in: 1...99
                    )

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Details")
                            .foregroundStyle(.secondary)

                        TextField(
                            "Item Details",
                            text: $details,
                            axis: .vertical
                        )
                        .lineLimit(3...5)
                    }

                } else {

                    LabeledContent("Item Name", value: item?.name ?? "")

                    LabeledContent(
                        "Default Quantity",
                        value: "\(item?.defaultQuantity ?? 1)"
                    )

                    if let details = item?.details,
                       !details.isEmpty {

                        LabeledContent("Details", value: details)
                    }
                }
            }

            // MARK: Category

            Section("Category") {

                if isEditing {

                    Picker(
                        "Select Category",
                        selection: $selectedCategoryID
                    ) {

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
                        Label(
                            "Create New Category",
                            systemImage: "plus.circle"
                        )
                        
                    }

                } else {

                    LabeledContent(
                        "Category",
                        value: item?.category.name ?? ""
                    )
                }
            }

            // MARK: Settings

            Section("Settings") {

                if isEditing {

                    Toggle(
                        "Automatically add to every trip",
                        isOn: $isAutoAdd
                    )

                } else {

                    LabeledContent(
                        "Automatic Add",
                        value: (item?.isAutoAdd ?? false) ? "Yes" : "No"
                    )
                }
            }

            // MARK: Save Button

            if isEditing {

                Section {
                    
                    SecondaryButton(
                        title: item == nil ? "Save Item" : "Save Changes",
                        icon: "checkmark"
                    ) {
                        saveItem()
                    }
                    .disabled(
                        name.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
                }
            }
        }

        // MARK: Navigation

        .navigationTitle(
            item == nil ? "New Item" :
            isEditing ? "Edit Item" : "Item Details"
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

        .toolbar {

            // Back Button

            ToolbarItem(placement: .navigationBarLeading) {

                Button {
                    dismiss()
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
            }

            // Edit Button

            if item != nil && !isEditing {

                ToolbarItem(placement: .confirmationAction) {

                    Button("Edit") {
                        isEditing = true
                    }
                }
            }
        }

        // MARK: New Category Sheet

        .sheet(isPresented: $showNewCategoryView) {

            NavigationStack {

                CategoryView { category in
                    selectedCategoryID = category.id
                }
            }
        }
    }

    // MARK: - Save Item

    private func saveItem() {

        guard let category = categories.first(where: {
            $0.id == selectedCategoryID
        }) else {
            return
        }

        let trimmedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if let item = item {

            // Update existing item

            item.name = trimmedName
            item.details = details.isEmpty ? nil : details
            item.defaultQuantity = defaultQuantity
            item.isAutoAdd = isAutoAdd
            item.category = category

        } else {

            // Create new item

            let newItem = Item(
                name: trimmedName,
                defaultQuantity: defaultQuantity,
                details: details.isEmpty ? nil : details,
                isAutoAdd: isAutoAdd,
                category: category
            )

            modelContext.insert(newItem)
        }

        do {

            try modelContext.save()

            if item != nil {

                // Return to read-only mode
                isEditing = false

            } else {

                // Close after creating a new item
                dismiss()
            }

        } catch {

            print("Error saving item: \(error.localizedDescription)")
        }
    }
}
