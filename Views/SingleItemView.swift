//
//  SingleItemView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 07.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct SingleItemView: View {

    let item: Item

    var body: some View {

        Form {

            // MARK: - Item Information

            Section("Item Information") {

                LabeledContent("Name") {
                    Text(item.name)
                }

                LabeledContent("Category") {
                    Text(item.category.name)
                }

                LabeledContent("Default Quantity") {
                    Text("\(item.defaultQuantity)")
                }

                if let details = item.details, !details.isEmpty {

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Details")
                            .foregroundStyle(.secondary)

                        Text(details)
                    }
                }
            }

            // MARK: - Settings

            Section("Settings") {

                LabeledContent("Automatic Add") {
                    Image(systemName: item.isAutoAdd
                          ? "checkmark.circle.fill"
                          : "circle")
                        .foregroundStyle(
                            item.isAutoAdd ? .green : .secondary
                        )
                }
            }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
