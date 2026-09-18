//
//  AppSettings.swift
//  123Pack
//
//  Created by Oliver Hartmann on 08.09.26.
//

import Foundation
import SwiftUI

enum Colors {

    static let primarycolor: Color = .darkBlueGrey
    static let backgroundcolor: Color = .brightSand
    static let cardcolor: Color = .warmWhite
    static let menubackgroundcolor: Color = .sunsetOrange
    static let menutextcolor: Color = .warmWhite
    static let carddarkcolor: Color = .darkSand
}

enum TripIcon: String, CaseIterable {
    case airplane = "airplane"
    case globe = "globe.europe.africa"
    case backpack = "backpack"
    case tent = "tent"
    case map = "map"
    case hiking = "figure.hiking"
}


enum MenuIcon: String {
    case trips = "airplane"
    case lists = "list.bullet"
    case items = "checklist"
    case category = "square.grid.2x2"
}
