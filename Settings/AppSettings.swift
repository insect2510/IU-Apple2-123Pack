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
    static let backgroundcolor: Color = .warmWhite
    static let cardcolor: Color = .warmWhite
    static let menubackgroundcolor: Color = .terra
    static let menutextcolor: Color = .warmWhite
    static let buttonbackgroundcolor: Color = .ocean
    static let buttontextcolor: Color = .warmWhite
}



// MARK: Icons for navigation and user action

enum NavIcons: String {
    case cancel = "xmark"
    case save = "checkmark"
    case back = "chevron.left"
    case new = "plus"
    case trash = "trash"
}

// MARK: Icons for main flying menu

enum MenuIcon: String {
    case trips = "airplane"
    case categories = "list.bullet"
    case items = "checklist"
}


// MARK: Icons for trips

enum TripIcon: String, CaseIterable {

    case airplane = "airplane"
    case backpack = "backpack"
    case camping = "tent"
    case city = "building.2"
    case hiking = "figure.hiking"
    case roadtrip = "car"
    case sailboat = "sailboat"

    var title: String {
        switch self {
        case .airplane: return "Airplane"
        case .backpack: return "Backpack"
        case .camping: return "Camping"
        case .city: return "Citytrip"
        case .hiking: return "Hiking"
        case .roadtrip: return "Roadtrip"
        case .sailboat: return "Sailing"
            
        }
    }

    var symbol: String {
        rawValue
    }
}


// MARK: Icons for categories

enum CategoryIcon: String, CaseIterable, Identifiable {

    case none = "folder"
    case accessories = "bag"
    case camping = "tent"
    case clothing = "tshirt"
    case documents = "doc.text"
    case food = "fork.knife"
    case hygiene = "shower"
    case medicine = "cross.case"
    case music = "headphones"
    case outdoor = "figure.hiking"
    case technology = "iphone"

    var id: String {
        rawValue
    }

    var title: String {
        switch self {

        case .none: return "None"
        case .accessories: return "Accessories"
        case .camping: return "Camping"
        case .clothing: return "Clothing"
        case .documents: return "Documents"
        case .food: return "Food"
        case .hygiene: return "Hygiene"
        case .medicine: return "Medicine"
        case .music: return "Music"
        case .outdoor: return "Outdoor"
        case .technology: return "Technology"
        }
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
