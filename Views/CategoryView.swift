//
//  CategoryView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 07.11.26.
//

import Foundation


import Foundation
import SwiftUI
import SwiftData

struct CategoryView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var category: Category?
    var onSave: ((Category) -> Void)?

    @State private var name = ""
    @State private var icon = ""
    @State private var categoryDescription = ""

    private var isEditing: Bool {
        category != nil
    }

    var body: some View {

        NavigationStack {

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

                    HStack {

                        Image(systemName: icon.isEmpty ? "folder" : icon)
                            .font(.system(size: 28))
                            .frame(width: 44)

                        Text(name.isEmpty ? "Category Name" : name)
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Category" : "New Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveCategory()
                    }
                    .disabled(name.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty)
                }
            }
            .onAppear {
                loadCategory()
            }
        }
    }

    // MARK: - Load Category

    private func loadCategory() {

        guard let category else { return }

        name = category.name
        icon = category.icon
        categoryDescription = category.categoryDescribtion
    }

    // MARK: - Save Category

    private func saveCategory() {

        let savedCategory: Category

        if let category {

            category.name = name
            category.icon = icon.isEmpty ? "folder" : icon
            category.categoryDescribtion = categoryDescription

            savedCategory = category

        } else {

            let newCategory = Category(
                name: name,
                icon: icon.isEmpty ? "folder" : icon,
                categoryDescribtion: categoryDescription
            )

            modelContext.insert(newCategory)

            savedCategory = newCategory
        }

        do {
            try modelContext.save()
            onSave?(savedCategory)
            dismiss()

        } catch {
            print("Error saving category: \(error.localizedDescription)")
        }
    }
}
