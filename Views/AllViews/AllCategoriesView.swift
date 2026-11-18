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
            
            NavigationStack {
                
                List {
                    Section("All Categories (\(categories.count))") {
                        
                        ForEach(categories) { category in
                            
                            NavigationLink {
                                SingleCategoryView(category: category)
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
                    PrimaryButton(
                        title: "New Category",
                        icon: NavIcons.new.rawValue
                    ) {
                        showNewCategoryView = true
                    }
                    
                }
                .navigationTitle("Categories")
                .navigationBarTitleDisplayMode(.large)
                
                .sheet(isPresented: $showNewCategoryView) {
                    
                    NavigationStack {
                        NewCategoryView()
                    }
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
