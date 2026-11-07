//
//  AllCategoriesView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 05.11.26.
//


import Foundation
import SwiftUI
import SwiftData


struct AllCategoriesView: View {
    
    @State private var showNewCategoryView = false

    @Query(sort: \Category.name) private var categories: [Category]

    var body: some View {

        NavigationStack {

            List {

                Section("All Categories (\(categories.count))") {

                    ForEach(categories) { category in

                        NavigationLink {
                            CategoryView(category: category)
                        } label: {

                            HStack(spacing: 12) {

                                Image(systemName: category.icon)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 28)

                                VStack(alignment: .leading, spacing: 4) {

                                    Text(category.name)
                                        .font(.headline)

                                    Text(category.categoryDescribtion)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()
                            }
                        }
                    }
                }
                
                Button {
                    showNewCategoryView = true
                } label: {
                    Label("Create New Category", systemImage: "plus.circle")
                }
            }
            .navigationTitle("All Categories")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showNewCategoryView) {
                CategoryView()
            }
        }
    }
}
