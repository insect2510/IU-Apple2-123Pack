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
    case newcircle = "plus.circle"
}

// MARK: Icons for main flying menu

enum MenuIcon: String {
    case trips = "airplane.up.right"
    case categories = "list.bullet"
    case items = "checklist"
}


// MARK: Icons for trips

enum TripIcon: String, CaseIterable {

    case backpack = "backpack"
    case holiday = "beach.umbrella"
    case business = "briefcase"
    case camping = "tent"
    case city = "building.2"
    case hiking = "mountain.2"
    case roadtrip = "car"
    case roundTheWorld = "globe"
    case sailboat = "sailboat"
    case schoolTrip = "house.lodge"


    var title: String {
        switch self {
     
        case .backpack: return "Backpacking Trip"
        case .holiday: return "Beach Holyday"
        case .business: return "Business Trip"
        case .camping: return "Camping Trip"
        case .city: return "City Trip"
        case .hiking: return "Hiking Trip"
        case .roadtrip: return "Road Trip"
        case .roundTheWorld: return "Round-the-World-Trip"
        case .sailboat: return "Sailing Trip"
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
    case sport = "dumbbell"
    case technology = "iphone"

    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .none: return "None"
        case .accessories: return "Accessories"
        case .books: return "Books"
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
