//
//  NewCategoryView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 02.11.26.
//

import Foundation

import SwiftUI
import SwiftData

struct XXXNewCategoryView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var onSave: (Category) -> Void

    @State private var name = ""
    @State private var icon = ""
    @State private var categoryDescription = ""

    var body: some View {

        NavigationStack {

            Form {

                Section("Category Information") {

                    TextField("Category Name", text: $name)

                    TextField("SF Symbol", text: $icon)

                    TextField(
                        "Description",
                        text: $categoryDescription
                    )
                }

                Section {

                    Button("Save Category") {
                        saveCategory()
                    }
                    .disabled(name.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty)
                }
            }
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveCategory() {

        let newCategory = Category(
            name: name,
            icon: icon.isEmpty ? "folder" : icon,
            categoryDescribtion: categoryDescription
        )

        modelContext.insert(newCategory)

        do {
            try modelContext.save()

            onSave(newCategory)
            dismiss()

        } catch {
            print("Error saving category: \(error)")
        }
    }
}
