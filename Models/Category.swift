//
//  PackingListCategory.swift
//  123Pack
//
//  Created by Oliver Hartmann on 08.09.26.
//

import Foundation
import SwiftData

import Foundation
import SwiftData

@Model
class Category {

    @Attribute(.unique)
    var id: UUID

    var name: String
    var icon: String
    var categoryDescribtion: String

    init(
        id: UUID = UUID(),
        name: String,
        icon: String,
        categoryDescribtion: String
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.categoryDescribtion = categoryDescribtion
    }
}

let exampleCategories: [Category] = [

    Category(
        name: "Kleidung",
        icon: CategoryIcon.clothing.rawValue,
        categoryDescribtion: "Alle Kleidungsstücke für deine Reise."
    ),

   Category(
        name: "Hygiene",
        icon: CategoryIcon.hygiene.rawValue,
        categoryDescribtion: "Körperpflege und Hygieneartikel."
    ),

    Category(
        name: "Medizin",
        icon: CategoryIcon.medicine.rawValue,
        categoryDescribtion: "Medikamente und Erste-Hilfe-Utensilien."
    ),

    Category(
        name: "Technik",
        icon: CategoryIcon.technology.rawValue,
        categoryDescribtion: "Elektronische Geräte und Zubehör."
    ),

    Category(
        name: "Dokumente",
        icon: CategoryIcon.documents.rawValue,
        categoryDescribtion: "Reisepass, Tickets und wichtige Unterlagen."
    ),

    Category(
        name: "Essen",
        icon: CategoryIcon.food.rawValue,
        categoryDescribtion: "Lebensmittel und Verpflegung."
    ),

    Category(
        name: "Camping",
        icon: CategoryIcon.camping.rawValue,
        categoryDescribtion: "Ausrüstung zum Übernachten und Campen."
    ),

    Category(
        name: "Outdoor",
        icon: CategoryIcon.outdoor.rawValue,
        categoryDescribtion: "Ausrüstung für Wanderungen und Outdoor-Aktivitäten."
    ),

    Category(
        name: "Accessoires",
        icon: CategoryIcon.accessories.rawValue,
        categoryDescribtion: "Zusätzliche Gegenstände und persönliche Accessoires."
    ),

    Category(
        name: "Musik",
        icon: CategoryIcon.music.rawValue,
        categoryDescribtion: "Kopfhörer und musikalisches Zubehör."
    )

]
