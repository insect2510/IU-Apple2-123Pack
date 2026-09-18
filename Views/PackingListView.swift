//
//  ContentView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 03.09.26.
//

import SwiftUI
import SwiftData

struct PackingListView: View {

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Header

            HeaderView()

            // MARK: - Scrollable Content

            ScrollView {

               
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Colors.backgroundcolor)

            // MARK: - Bottom Menu

            BottomMenuView()
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colors.backgroundcolor)

    }



}


// MARK: - Preview

#Preview {
    PackingListView()
        
}
