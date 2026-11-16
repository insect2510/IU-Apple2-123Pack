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

    let item: Item

    var body: some View {

        Form {

            // MARK: - Item Information

            Section("Item Information") {

                LabeledContent("Item Name", value: item.name)

                LabeledContent(
                    "Default Quantity",
                    value: "\(item.defaultQuantity)"
                )

                if let details = item.details, !details.isEmpty {
                    LabeledContent("Details", value: details)
                }
            }

            // MARK: - Category

            Section("Category") {

                LabeledContent(
                    "Category",
                    value: item.category.name
                )
            }
        }

        // MARK: - Navigation

        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

        .toolbar {

            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                NavigationLink {
                    EditItemView(item: item)
                } label: {
                    Text("Edit")
                }
            }
        }
    }
}
