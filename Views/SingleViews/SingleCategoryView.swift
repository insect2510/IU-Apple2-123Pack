//
//  SingleCategoryView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 18.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct SingleCategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let category: Category
    
    @State private var showDeleteConfirmation = false
    @State private var showEditCategory = false
    
    
    // MARK: - Assigned Items
    
    // Items sort by name
    @Query(sort: \Item.name)
    private var items: [Item]
    
    private var categoryItems: [Item] {
        items.filter {
            $0.category.persistentModelID == category.persistentModelID
        }
    }
    
    var body: some View {
        
        List {
            
            // MARK: - Item Name
            
            HStack(spacing: 8) {
                
                // MARK: - Category Icon
                Image(systemName: category.icon)
                    .font(.title)
                
                Text(category.name)
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            // MARK: - Category Details
            
            Section {
                
                if !category.details.isEmpty {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Details")
                            .foregroundStyle(.secondary)
                        
                        Text(category.details)
                    }
                }
            }
                        
            // MARK: - Assigned Items
            
            Section("Assigned Items (\(categoryItems.count))") {
                
                if categoryItems.isEmpty {
                    
                    Text("No items assigned to this category.")
                        .foregroundStyle(.secondary)
                    
                } else {
                    
                    ForEach(categoryItems) { item in
                        
                        NavigationLink {
                            SingleItemView(item: item)
                        } label: {
                            
                            HStack(spacing: 12) {
                                
                                Image(systemName: item.category.icon)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 28)
                                
                                Text(item.name)
                            }
                        }
                    }
                }
            }
            
            // MARK: Actions
            
            Section {
                
                HStack {
                    
                    PrimaryButton(
                        title: "Edit Category",
                        icon: NavIcons.edit.rawValue
                    ) {
                        showEditCategory = true
                    }
                    
                    Spacer()
                    
                    PrimaryButton(
                        title: "Delete Category",
                        icon: NavIcons.trash.rawValue
                    ) {
                        showDeleteConfirmation = true
                    }
                    .disabled(!categoryItems.isEmpty)
                }
                .listRowBackground(Color.clear)
            }
            
        }
        
        // MARK: - Navigation
        
        .scrollContentBackground(.hidden)
        .background(Colors.backgroundcolor)
        .navigationTitle("Category Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showEditCategory) {
            EditCategoryView(category: category)
        }
        
        .toolbar {
            ToolbarEdit(
                dismissAction: {
                    dismiss()
                },
                editDestination: AnyView(
                    EditCategoryView(category: category)
                )
            )
        }
        
        // MARK: - Delete Dialog
        
        .confirmationDialog(
            "Delete Category?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            
            Button("Delete Category", role: .destructive) {
                deleteCategory()
            }
            
            Button("Cancel", role: .cancel) {}
            
        } message: {
            
            Text("Are you sure you want to delete this category?")
        }
    }
    
    // MARK: - Delete Category
    
    private func deleteCategory() {
        
        // Prevent deletion if items are assigned
        
        guard categoryItems.isEmpty else {
            return
        }
        
        modelContext.delete(category)
        
        do {
            
            try modelContext.save()
            dismiss()
            
        } catch {
            
            print(
                "Error deleting category: \(error.localizedDescription)"
            )
        }
    }
}
