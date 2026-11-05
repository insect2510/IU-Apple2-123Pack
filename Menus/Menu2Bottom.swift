//
//  BottomMenuView.swift
//  123Pack
//

import SwiftUI

struct Menu2Bottom: View {

    var body: some View {
        HStack(spacing: 0) {

            // Trips
            MenuItemView(
                icon: MenuIcon.trips.rawValue,
                title: "Trips"
            )


            // Items
            NavigationLink {
                AllItemsView()
            } label: {
                MenuItemView(
                    icon: MenuIcon.items.rawValue,
                    title: "Items"
                )
            }
            .buttonStyle(.plain)

            
           // Category
            NavigationLink {
                AllCategoriesView()
            } label: {
                MenuItemView(
                    icon: MenuIcon.categories.rawValue,
                    title: "Category"
                )
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(Colors.menubackgroundcolor)
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
