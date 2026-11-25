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
    @State private var details: String

    // MARK: - Initializer

    init(category: Category) {

        self.category = category

        _name = State(initialValue: category.name)
        _icon = State(initialValue: category.icon)
        _details = State(
            initialValue: category.details
        )
    }

    // MARK: - Body

    var body: some View {

        Form {

            // MARK: - Category Information

            Section("Category Information") {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Category Name")
                        .foregroundStyle(.primary)
                    
                    PrimaryTextField(title: "No category without a name", text: $name)
                }
                
                VStack(alignment: .leading, spacing: 8) {

                    Text("Category Details")
                        .foregroundStyle(.primary)

                    PrimaryTextField(
                        title: "Category Details",
                        text: $details,
                    )
                    .lineLimit(3...5)
                }
            }
            
            // MARK: - Category Icon
            
            Section("Category Icon") {

                Picker("Select Icon:", selection: $icon) {
                    
                    Text("Select Icon:")

                    ForEach(CategoryIcon.allCases) { categoryIcon in
                        
                        HStack(spacing: 8) {
                            Image(systemName: categoryIcon.rawValue)
                                .foregroundStyle(.secondary)
                            Text(categoryIcon.title)
                        }
                        .tag(categoryIcon.rawValue)
                    }
                }
            }
        }

        // MARK: - Navigation
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollContentBackground(.hidden)

        .navigationTitle("Edit Category")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

        .toolbar {
            ToolbarSave(
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
        category.details = details

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
