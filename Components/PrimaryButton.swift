//
//  PrimaryButton.swift
//  123Pack
//
//  Created by Oliver Hartmann on 12.11.26.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    
    let title: String
    let icon: String?
    let action: () -> Void
    
    var body: some View {
        
        Button (action: action) {
            
            VStack (spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                }

                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .textCase(.uppercase)

                }
                .buttonStyle(.plain)
                
            }
        .foregroundStyle(Colors.buttontextcolor)
        .frame(width: 150, height: 100)
        .background(Colors.buttonbackgroundcolor)
        .clipShape(RoundedRectangle(cornerRadius: 8))

    }
}


