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
  //  case category = "square.grid.2x2"
}



enum CategoryIcon: String, CaseIterable, Identifiable {

    case clothing = "tshirt"
    case hygiene = "shower"
    case medicine = "cross.case"
    case technology = "iphone"
    case documents = "doc.text"
    case food = "fork.knife"
    case camping = "tent"
    case outdoor = "figure.hiking"
    case accessories = "bag"
    case music = "headphones"

    var id: String {
        rawValue
    }
}


enum ItemIcon: String, CaseIterable, Identifiable {

    // Kleidung
    case tshirt = "tshirt"
    case pants = "figure.walk"
    case shoes = "shoe"
    case socks = "tshirt.fill"
    case jacket = "cloud"

    // Hygiene
    case toothbrush = "mouth"
    case shampoo = "shower"
    case towel = "rectangle.portrait"

    // Medizin
    case firstAid = "cross.case"
    case medication = "pills"
    case sunscreen = "sun.max"

    // Technik
    case smartphone = "iphone"
    case charger = "battery.100.bolt"
    case headphones = "headphones"
    case camera = "camera"
    case laptop = "laptopcomputer"

    // Dokumente & Geld
    case passport = "person.text.rectangle"
    case wallet = "wallet.pass"
    case creditCard = "creditcard"

    // Essen
    case waterBottle = "waterbottle"
    case snacks = "fork.knife"
    case mug = "mug"

    // Camping & Outdoor
    case tent = "tent"
    case sleepingBag = "bed.double"
    case flashlight = "flashlight.on.fill"
    case backpack = "backpack"

    // Sonstiges
    case sunglasses = "sunglasses"
    case book = "book"
    case padlock = "lock"

    var id: String {
        rawValue
    }
}
