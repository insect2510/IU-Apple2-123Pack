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
        
        ZStack {
            
            Colors.backgroundcolor
                .ignoresSafeArea()
            
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
                    
                    // MARK: Button Create New Category
                    SecondaryButton(
                        title: "Create New Category",
                        icon: "plus"
                    ) {
                        showNewCategoryView = true
                    }
                    
                }
                .navigationTitle("Categories")
                .navigationBarTitleDisplayMode(.large)
                .sheet(isPresented: $showNewCategoryView) {
                    CategoryView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
            
            

        }
    }
}

// MARK: - Preview

#Preview {
    AllCategoriesView()
}
