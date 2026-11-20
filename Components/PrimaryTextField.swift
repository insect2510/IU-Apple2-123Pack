//
//  PrimaryTextField.swift
//  123Pack
//
//  Created by Oliver Hartmann on 20.11.26.
//

import Foundation

import SwiftUI

struct PrimaryTextField: View {

    let title: String

    @Binding var text: String

    var body: some View {

        TextField(title, text: $text, axis: .vertical)
            .padding(12)
            .background(Colors.cardcolor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(
                        Color.gray.opacity(0.4),
                        lineWidth: 1
                    )
            }
    }
}
