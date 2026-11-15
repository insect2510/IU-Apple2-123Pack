//
//  SecondaryButton.swift
//  123Pack
//
//  Created by Oliver Hartmann on 15.11.26.
//

import Foundation
import SwiftUI

struct SecondaryButton: View {
    
    @Environment(\.isEnabled) private var isEnabled
    
    let title: String
    let icon: String?
    let action: () -> Void
    
    var body: some View {
        
        Button (action: action) {
            HStack (spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .medium))
                }

                Text(title)
                    .textCase(.uppercase)

                }
            .foregroundStyle(Colors.buttontextcolor)
            .padding(16)
            .background(Colors.buttonbackgroundcolor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .opacity(isEnabled ? 1.0 : 0.4)

        }

    }
}
