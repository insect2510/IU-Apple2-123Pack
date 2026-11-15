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
    @State private var showItemView = false

    var body: some View {

        NavigationStack {

            List {

                Section("All Items (\(items.count))") {

                    ForEach(items) { item in

                        NavigationLink {
                            ItemView(item: item)
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
                
                SecondaryButton(
                    title: "Create New Item",
                    icon: "plus"
                ) {
                    showItemView = true
                }
            }
            
            .navigationTitle("Items")
            .navigationBarTitleDisplayMode(.large)
        }
        
        // MARK: Sheet für NewItemView

        .sheet(isPresented: $showItemView) {
            ItemView()
        }
        .padding(0)
    }
}
