
//
//  CategoryView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 07.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct CategoryView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let category: Category?
    var onSave: ((Category) -> Void)?

    // MARK: - Form Properties

    @State private var name = ""
    @State private var icon = "folder"
    @State private var categoryDescription = ""

    @State private var isEditing: Bool
    @State private var showIconPreview = true

    // MARK: - Initializer

    init(
        category: Category? = nil,
        onSave: ((Category) -> Void)? = nil
    ) {

        self.category = category
        self.onSave = onSave

        _isEditing = State(initialValue: category == nil)

        _name = State(initialValue: category?.name ?? "")
        _icon = State(initialValue: category?.icon ?? "folder")
        _categoryDescription = State(
            initialValue: category?.categoryDescribtion ?? ""
        )
    }

    // MARK: - Body

    var body: some View {

        Form {

            // MARK: Category Information

            Section("Category Information") {

                if isEditing {

                    TextField("Category Name", text: $name)

                    Picker("Select Icon", selection: $icon) {

                        ForEach(CategoryIcon.allCases) { categoryIcon in

                            Label(
                                categoryIcon.title,
                                systemImage: categoryIcon.rawValue
                            )
                            .tag(categoryIcon.rawValue)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Description")
                            .foregroundStyle(.secondary)

                        TextField(
                            "Category Description",
                            text: $categoryDescription,
                            axis: .vertical
                        )
                        .lineLimit(3...5)
                    }

                } else {

                    LabeledContent(
                        "Category Name",
                        value: category?.name ?? ""
                    )

                    LabeledContent("Icon") {

                        Image(systemName: category?.icon ?? "folder")
                            .font(.system(size: 20))
                    }

                    if let description = category?.categoryDescribtion,
                       !description.isEmpty {

                        LabeledContent("Description", value: description)
                    }
                }
            }

            // MARK: Icon Preview

            Section("Icon Preview") {

                HStack(spacing: 16) {

                    Image(systemName: icon.isEmpty ? "folder" : icon)
                        .font(.system(size: 28))
                        .frame(width: 44)

                    Text(name.isEmpty ? "Category Name" : name)
                        .fontWeight(.semibold)
                }
            }

            // MARK: Save Button

            if isEditing {
                
                    SecondaryButton(
                        title: category == nil ? "Save Category" : "Save Changes",
                        icon: "checkmark"
                    ) {
                        saveCategory()
                    }
                    .disabled(
                        name.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty
                    )
            }
        }

        // MARK: Navigation

        .navigationTitle(
            category == nil ? "New Category" :
            isEditing ? "Edit Category" : "Category Details"
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

            // Edit / Cancel Button

            if category != nil {

                ToolbarItem(placement: .navigationBarTrailing) {

                    Button(isEditing ? "Cancel" : "Edit") {

                        if isEditing {

                            resetCategory()
                            isEditing = false

                        } else {

                            isEditing = true
                        }
                    }
                }
            }
        }
    }

    // MARK: - Reset Category

    private func resetCategory() {

        guard let category else { return }

        name = category.name
        icon = category.icon
        categoryDescription = category.categoryDescribtion
    }

    // MARK: - Save Category

    private func saveCategory() {

        let trimmedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let savedCategory: Category

        if let category {

            // Update existing category

            category.name = trimmedName
            category.icon = icon.isEmpty ? "folder" : icon
            category.categoryDescribtion = categoryDescription

            savedCategory = category

        } else {

            // Create new category

            let newCategory = Category(
                name: trimmedName,
                icon: icon.isEmpty ? "folder" : icon,
                categoryDescribtion: categoryDescription
            )

            modelContext.insert(newCategory)

            savedCategory = newCategory
        }

        do {

            try modelContext.save()

            onSave?(savedCategory)

            if category != nil {

                // Return to read-only mode
                isEditing = false

            } else {

                // Close after creating a new category
                dismiss()
            }

        } catch {

            print("Error saving category: \(error.localizedDescription)")
        }
    }
}
