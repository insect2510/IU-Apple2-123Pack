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

    var body: some View {

        NavigationStack {

            List {

                Section("All Items (\(items.count))") {

                    ForEach(items) { item in

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
            .navigationTitle("All Items")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
