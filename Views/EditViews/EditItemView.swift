//
//  EditItemView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 17.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct EditItemView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let item: Item
    
    @Query(sort: \Category.name)
    private var categories: [Category]
    
    // MARK: - Form Properties
    
    @State private var name: String
    @State private var details: String
    @State private var defaultQuantity: Int
    @State private var selectedCategoryID: UUID?
    
    @State private var showNewCategoryView = false
    
    // MARK: - Initializer
    
    init(item: Item) {
        
        self.item = item
        
        _name = State(initialValue: item.name)
        _details = State(initialValue: item.details ?? "")
        _defaultQuantity = State(initialValue: item.defaultQuantity)
        _selectedCategoryID = State(initialValue: item.category.id)
    }
    
    // MARK: - Body
    
    var body: some View {
        
        Form {
            
            // MARK: - Item Information
            
            Section("Item Information") {
                
                // MARK: Trip Name
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Item Name")
                        .foregroundStyle(.primary)
                    
                    PrimaryTextField(title: "No item without a name", text: $name)
                }
                
                // MARK: Default Quantity
                
                Stepper(
                    "Default Quantity: \(defaultQuantity)",
                    value: $defaultQuantity,
                    in: 1...99
                )
                
                
                // MARK: Trip Details
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Item Details")
                        .foregroundStyle(.primary)
                    
                    PrimaryTextField(
                        title: "Enter some details",
                        text: $details,
                    )
                    .lineLimit(3...5)
                }
                
            }
            
            Section("Item Category") {
                
                // MARK: - Category
                
                Picker(
                    "Select Category:",
                    selection: $selectedCategoryID
                ) {
                    
                    Text("Select Category")
                        .tag(nil as UUID?)
                    
                    ForEach(categories) { category in
                        
                        HStack(spacing: 8) {
                            Image(systemName: category.icon)
                                .foregroundStyle(.secondary)
                            Text(category.name)
                        }
                        .tag(category.id as UUID?)
                    }
                }
                
                // MARK: - New Category Button
                
                Button {
                    print("Create New Category clicked")
                    showNewCategoryView = true
                    
                } label: {
                    Label(
                        "Create New Category",
                        systemImage: "plus.circle"
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    
    
    // MARK: - Navigation
    
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollContentBackground(.hidden)
    
        .navigationTitle("Edit Item")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    
    // MARK: - Toolbar
    
        .toolbar {
            ToolbarSave(
                cancelAction: {
                    dismiss()
                },
                saveAction: {
                    saveChanges()
                },
                saveDisabled: name.trimmingCharacters(
                    in: .whitespaces
                ).isEmpty
            )
        }
    
    // MARK: - New Category Sheet
    
        .sheet(isPresented: $showNewCategoryView) {
            NavigationStack {
                NewCategoryView { category in
                    selectedCategoryID = category.id
                }
            }
        }
}

// MARK: - Save Changes

private func saveChanges() {
    
    guard let category = categories.first(where: {
        $0.id == selectedCategoryID
    }) else {
        return
    }
    
    let trimmedName = name.trimmingCharacters(
        in: .whitespacesAndNewlines
    )
    
    item.name = trimmedName
    item.details = details.isEmpty ? nil : details
    item.defaultQuantity = defaultQuantity
    item.category = category
    
    do {
        try modelContext.save()
        dismiss()
    } catch {
        print("Error updating item: \(error.localizedDescription)")
    }
}
}
