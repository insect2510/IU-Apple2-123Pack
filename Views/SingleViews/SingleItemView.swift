//
//  SingleItemView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 17.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct SingleItemView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let item: Item
    
    @State private var showDeleteConfirmation = false

    var body: some View {

        Form {
            
            HStack(spacing: 8) {
                
                
                // MARK: - Item Name

                Text(item.name)
                    .font(.title)
                
            }

            // MARK: - Item Information

            Section() {
            
                
                // MARK: - Default Quantity
                
                HStack {
                    
                    Text("Default Quantity:")
                    
                    Spacer()
                    
                    Text("\(item.defaultQuantity)")
                    
                }
                
                // MARK: - Details

                if let details = item.details, !details.isEmpty {
                    
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Details:")
                            .foregroundStyle(.secondary)

                        Text(item.details ?? "...")
                     
                    }
                }
                
                // MARK: - Category
                
                HStack {
                    
                    Text("Category:")
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Image(systemName: item.category.icon)
                            .foregroundStyle(.secondary)
                        Text(item.category.name)
                    }
                }
            }
            
            // MARK: - Delete Item

            Section {
                
                PrimaryButton(
                    title: "Delete Item",
                    icon: NavIcons.trash.rawValue
                ) {
                    showDeleteConfirmation = true
                }
            }
        }

        // MARK: - Navigation

        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarDetails(
                dismissAction: {
                    dismiss()
                },
                editDestination: AnyView(
                    EditItemView(item: item)
                )
            )
        }
        
        // MARK: - Delete Dialog
        
        .confirmationDialog(
            "Delete Item?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {

            Button("Delete Item", role: .destructive) {
                deleteItem()
            }

            Button("Cancel", role: .cancel) {}

        } message: {

            Text("Are you sure you want to delete this item?")
        }
    }
    
    // MARK: - Delete Trip

    private func deleteItem() {

        modelContext.delete(item)

        do {

            try modelContext.save()
            dismiss()


        } catch {

            print(
                "Error deleting item: \(error.localizedDescription)"
            )
        }
    }
}
