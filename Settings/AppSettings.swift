//
//  AppSettings.swift
//  123Pack
//
//  Created by Oliver Hartmann on 08.09.26.
//

import Foundation
import SwiftUI

enum Colors {

    static let primarycolor: Color = .blueGrey
    static let backgroundcolor: Color = .white
    static let cardbackgroundcolor: Color = .darkSand
    static let cardtextdcolor: Color = .blueGrey
    static let menubackgroundcolor: Color = .terra
    static let menutextcolor: Color = .white
    static let buttonbackgroundcolor: Color = .ocean
    static let buttontextcolor: Color = .white
}



// MARK: Icons for navigation and user action

enum NavIcons: String {
    case cancel = "xmark"
    case save = "checkmark"
    case back = "chevron.left"
    case new = "plus"
    case trash = "trash"
    case edit = "pencil"
}

// MARK: Icons for main flying menu

enum MenuIcon: String {
    case trips = "airplane"
    case categories = "list.bullet"
    case items = "checklist"
}


// MARK: Icons for trips

enum TripIcon: String, CaseIterable {

    case backpack = "backpack"
    case business = "briefcase"
    case camping = "tent"
    case city = "building.2"
    case hiking = "figure.hiking"
    case holiday = "airplane"
    case musicGig = "music.mic"
    case roadtrip = "car"
    case roundTheWorld = "globe"
    case sailboat = "sailboat"
    case schoolTrip = "house.lodge"


    var title: String {
        switch self {
     
        case .backpack: return "Backpack"
        case .business: return "Business"
        case .camping: return "Camping"
        case .city: return "Citytrip"
        case .hiking: return "Hiking"
        case .holiday: return "Holyday"
        case .musicGig: return "Music Gig"
        case .roadtrip: return "Roadtrip"
        case .roundTheWorld: return "Round-the-World Trip"
        case .sailboat: return "Sailing"
        case .schoolTrip: return "School Trip"
            
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
    case books = "book"
    case camping = "tent"
    case clothing = "tshirt"
    case documents = "doc.text"
    case food = "fork.knife"
    case footwear = "shoe"
    case hygiene = "shower"
    case medicine = "cross.case"
    case money = "wallet.bifold"
    case music = "headphones"
    case outdoor = "figure.hiking"
    case photography = "camera"
    case sleeping = "bed.double"
    case sport = "figure.run"
    case technology = "iphone"

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .none: return "None"
        case .accessories: return "Accessories"
        case .books: return "Books"
        case .camping: return "Camping"
        case .clothing: return "Clothing"
        case .documents: return "Documents"
        case .food: return "Food"
        case .footwear: return "Footwear"
        case .hygiene: return "Hygiene"
        case .medicine: return "Medicine"
        case .money: return "Money"
        case .music: return "Music"
        case .outdoor: return "Outdoor"
        case .photography: return "Photography"
        case .sleeping: return "Sleeping"
        case .sport: return "Sport"
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
