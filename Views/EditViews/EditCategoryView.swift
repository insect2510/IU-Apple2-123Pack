//
//  EditCategoryView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 18.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct EditCategoryView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let category: Category

    // MARK: - Form Properties

    @State private var name: String
    @State private var icon: String
    @State private var categoryDescription: String

    // MARK: - Initializer

    init(category: Category) {

        self.category = category

        _name = State(initialValue: category.name)
        _icon = State(initialValue: category.icon)
        _categoryDescription = State(
            initialValue: category.categoryDescribtion
        )
    }

    // MARK: - Body

    var body: some View {

        Form {

            // MARK: - Category Information

            Section("Category Information") {

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
            }

            // MARK: - Icon Preview

            Section("Icon Preview") {

                HStack(spacing: 16) {

                    Image(systemName: icon.isEmpty ? "folder" : icon)
                        .font(.system(size: 28))
                        .frame(width: 44)

                    Text(name.isEmpty ? "Category Name" : name)
                        .fontWeight(.semibold)
                }
            }
        }

        // MARK: - Navigation

        .navigationTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

        .toolbar {
            ToolbarEdit(
                cancelAction: {
                    dismiss()
                },
                saveAction: {
                    saveChanges()
                },
                saveDisabled: name.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ).isEmpty
            )
        }
    }

    // MARK: - Save Changes

    private func saveChanges() {

        let trimmedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        category.name = trimmedName
        category.icon = icon.isEmpty ? "folder" : icon
        category.categoryDescribtion = categoryDescription

        do {
            try modelContext.save()
            dismiss()

        } catch {
            print(
                "Error updating category: \(error.localizedDescription)"
            )
        }
    }
}
