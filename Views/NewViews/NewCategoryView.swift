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
    @State private var icon = CategoryIcon.allCases.first?.rawValue ?? "folder"
    @State private var details = ""
    
    // MARK: - Body
    
    var body: some View {
        
        Form {
            
            // MARK: - Category Information
            
            Section("Category Information") {
                
                // MARK: - Category Name
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Category Name")
                        .foregroundStyle(.primary)
                    
                    PrimaryTextField(title: "No category without a name", text: $name)
                }
                
                // MARK: - Category Details
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Category Details")
                        .foregroundStyle(.primary)
                    
                    PrimaryTextField(
                        title: "Enter some details",
                        text: $details,
                    )
                    .lineLimit(3...5)
                }
                
            }
            
            // MARK: - Category Icon
            
            Section("Category Icon") {
                
                Picker("Select Icon", selection: $icon) {
                    
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
        
        .navigationTitle("New Category")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
        .toolbar {
            ToolbarSave(
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
            details: details
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
