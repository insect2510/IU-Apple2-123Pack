//
//  BottomMenuView.swift
//  123Pack
//

import SwiftUI

struct Menu2Bottom: View {
    
    var body: some View {
        
        TabView {
            
            // Trips
            
            Tab("Trips", systemImage: MenuIcon.trips.rawValue) {
                
                NavigationStack {
                    
                    AllTripsView()
                    
                }
                
            }
            
            // Items    AllItemsView()
            
            Tab("Items", systemImage: MenuIcon.items.rawValue) {
                
                NavigationStack {
                    
                    AllItemsView()
                    
                }
                
            }
            
            // CategoryAllCategoriesView()
            
            Tab("Category", systemImage: MenuIcon.categories.rawValue) {
                
                NavigationStack {
                    
                    AllCategoriesView()
                    
                }
                
            }
            
        }
        
        .frame(maxWidth: .infinity)
        .tint(Colors.primarycolor)
        .toolbarBackground(Colors.menubackgroundcolor, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.light, for: .tabBar)
    }
}


// MARK: - Menu Item

struct MenuItemView: View {
    
    let icon: String
    let title: String
    
    var body: some View {
        VStack(spacing: 4) {
            
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundStyle(Colors.menutextcolor)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(Colors.menutextcolor)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}


// MARK: - Preview

#Preview {
    Menu2Bottom()
}
