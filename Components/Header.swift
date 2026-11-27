//
//  Header.swift
//  123Pack
//
//  Created by Oliver Hartmann on 18.09.26.
//

import SwiftUI

struct Header: View {

    var body: some View {
        
        HStack {

            Text("123PACK")
                .font(.largeTitle.bold())
                .foregroundStyle(Colors.menutextcolor)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Colors.menubackgroundcolor)
    }
}

#Preview {
    Header()
}
