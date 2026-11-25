//
//  NewItemView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 17.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct NewItemView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Category.name)
    private var categories: [Category]
    
    // MARK: - Form Properties
    
    @State private var name = ""
    @State private var details = ""
    @State private var defaultQuantity = 1
    @State private var selectedCategoryID: UUID?
    
    @State private var showNewCategoryView = false
    
    // MARK: - Body
    
    var body: some View {
        
        Form {
            
            // MARK: - Item Information
            
            Section("Item Information") {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Item Name")
                        .foregroundStyle(.primary)
                    
                    PrimaryTextField(title: "No item without a name", text: $name)
                }
                
                // MARK: - Quantity
                
                Stepper(
                    "Default Quantity: \(defaultQuantity)",
                    value: $defaultQuantity,
                    in: 1...99
                )
                
                // MARK: - Item Details
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Item Details")
                        .foregroundStyle(.primary)
                    
                    PrimaryTextField(
                        title: "Item Details",
                        text: $details,
                    )
                    .lineLimit(3...5)
                }
            }
            
            // MARK: - Category
            
            Section("Category") {
                
                Picker(
                    "Select Category",
                    selection: $selectedCategoryID
                ) {
                    
                    Text("Select Category:")
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
                .onAppear {
                    if selectedCategoryID == nil {
                        selectedCategoryID = categories.first?.id
                    }
                }
                
                Button {
                    
                    showNewCategoryView = true
                    
                } label: {
                    Label(
                        "Create New Category",
                        systemImage: NavIcons.newcircle.rawValue
                    )
                }
            }
        }
        
        // MARK: - Navigation
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollContentBackground(.hidden)
        
        .navigationTitle("New Item")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        
        // MARK: - Toolbar
        
        .toolbar {
            ToolbarSave(
                cancelAction: {
                    dismiss()
                },
                saveAction: {
                    saveItem()
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
        
        let newItem = Item(
            name: trimmedName,
            defaultQuantity: defaultQuantity,
            details: details.isEmpty ? nil : details,
            category: category
        )
        
        modelContext.insert(newItem)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error creating item: \(error.localizedDescription)")
        }
    }
}
