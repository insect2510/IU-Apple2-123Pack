//
//  NewCategoryView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 18.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct NewCategoryView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var onSave: ((Category) -> Void)?

    // MARK: - Form Properties

    @State private var name = ""
    @State private var icon = "folder"
    @State private var categoryDescription = ""

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

            // MARK: - Save Button

            Section {

                SecondaryButton(
                    title: "Save Category",
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

        // MARK: - Navigation

        .navigationTitle("New Category")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

        .toolbar {
            ToolbarEdit(
                cancelAction: {
                    dismiss()
                },
                saveAction: {
                    saveCategory()
                },
                saveDisabled: name.trimmingCharacters(
                    in: .whitespacesAndNewlines
                ).isEmpty
            )
        }
    }

    // MARK: - Save Category

    private func saveCategory() {

        let trimmedName = name.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedName.isEmpty else {
            return
        }

        let newCategory = Category(
            name: trimmedName,
            icon: icon.isEmpty ? "folder" : icon,
            categoryDescribtion: categoryDescription
        )

        modelContext.insert(newCategory)

        do {
            try modelContext.save()

            onSave?(newCategory)

            dismiss()

        } catch {
            print(
                "Error creating category: \(error.localizedDescription)"
            )
        }
    }
}
