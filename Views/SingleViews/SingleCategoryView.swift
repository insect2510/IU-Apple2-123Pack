//
//  SingleCategoryView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 18.11.26.
//

import Foundation
import SwiftUI
import SwiftData

struct SingleCategoryView: View {

    @Environment(\.dismiss) private var dismiss

    let category: Category

    var body: some View {

        Form {

            // MARK: - Category Information

            Section("Category Information") {

                HStack {
                    Text("Category Name")
                    Spacer()
                    Text(category.name)
                }

                HStack {
                    Text("Icon")
                    Spacer()

                    Image(systemName: category.icon)
                        .font(.system(size: 20))
                }

                if !category.categoryDescribtion.isEmpty {

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Description")
                            .foregroundStyle(.secondary)

                        Text(category.categoryDescribtion)
                    }
                }
            }

            // MARK: - Icon Preview

            Section("Icon Preview") {

                HStack(spacing: 16) {

                    Image(systemName: category.icon)
                        .font(.system(size: 28))
                        .frame(width: 44)

                    Text(category.name)
                        .fontWeight(.semibold)
                }
            }
        }

        // MARK: - Navigation

        .navigationTitle("Category Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

        .toolbar {
            ToolbarDetails(
                dismissAction: {
                    dismiss()
                },
                editDestination: AnyView(
                    EditCategoryView(category: category)
                )
            )
        }
    }
}
