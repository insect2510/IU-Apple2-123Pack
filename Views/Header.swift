//
//  Header.swift
//  123Pack
//
//  Created by Oliver Hartmann on 18.09.26.
//

import SwiftUI

struct HeaderView: View {

    var body: some View {
        HStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(Colors.menutextcolor)

            Text("123PACK")
                .font(.largeTitle.bold())
                .foregroundStyle(Colors.menutextcolor)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 24)
        .background(Colors.menubackgroundcolor)
    }
}

#Preview {
    HeaderView()
}
