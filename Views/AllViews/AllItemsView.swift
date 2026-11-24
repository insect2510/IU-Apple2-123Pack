//
//  AllItemsView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 05.11.26.
//


import Foundation
import SwiftUI
import SwiftData

struct AllItemsView: View {
    
    @Query(sort: \Item.name) private var items: [Item]
    @State private var showNewItemView = false
    
    var body: some View {
        
        ZStack {
            
            Colors.backgroundcolor
                .ignoresSafeArea()
            
            List {
                
                Section("All Items (\(items.count))") {
                    
                    ForEach(items) { item in
                        
                        NavigationLink {
                            SingleItemView(item: item)
                        } label: {
                            
                            HStack(spacing: 12) {
                                
                                Image(systemName: item.category.icon)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 28)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.category.name)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Text("× \(item.defaultQuantity)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

  
                
                
                // MARK: Button Create New Item
                
                PrimaryButton(
                    title: "New Item",
                    icon: "plus"
                ) {
                    showNewItemView = true
                }
               
            }
            .navigationTitle("Items")
            .navigationBarTitleDisplayMode(.large)
    
            
        }
        .preferredColorScheme(.light)
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollContentBackground(.hidden)
        
        
        // MARK: Sheet für NewItemView
        
        .sheet(isPresented: $showNewItemView) {
            
            NavigationStack{
                NewItemView()
            }
            
            
        }
        .padding(0)
 
    }
}

#Preview {
    AllItemsView()
}
