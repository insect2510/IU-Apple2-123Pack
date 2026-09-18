//
//  123PackApp.swift
//  123Pack
//
//  Created by Oliver Hartmann on 03.09.26.
//

import SwiftUI
import SwiftData

@main
struct App123PackApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Trip.self,
            PackingList.self
        ])
    }
}
