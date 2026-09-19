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
class PackingListItemCategory {

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

let exampleCategories: [PackingListItemCategory] = [

    PackingListItemCategory(
        name: "Kleidung",
        icon: CategoryIcon.clothing.rawValue,
        categoryDescribtion: "Alle Kleidungsstücke für deine Reise."
    ),

    PackingListItemCategory(
        name: "Hygiene",
        icon: CategoryIcon.hygiene.rawValue,
        categoryDescribtion: "Körperpflege und Hygieneartikel."
    ),

    PackingListItemCategory(
        name: "Medizin",
        icon: CategoryIcon.medicine.rawValue,
        categoryDescribtion: "Medikamente und Erste-Hilfe-Utensilien."
    ),

    PackingListItemCategory(
        name: "Technik",
        icon: CategoryIcon.technology.rawValue,
        categoryDescribtion: "Elektronische Geräte und Zubehör."
    ),

    PackingListItemCategory(
        name: "Dokumente",
        icon: CategoryIcon.documents.rawValue,
        categoryDescribtion: "Reisepass, Tickets und wichtige Unterlagen."
    ),

    PackingListItemCategory(
        name: "Essen",
        icon: CategoryIcon.food.rawValue,
        categoryDescribtion: "Lebensmittel und Verpflegung."
    ),

    PackingListItemCategory(
        name: "Camping",
        icon: CategoryIcon.camping.rawValue,
        categoryDescribtion: "Ausrüstung zum Übernachten und Campen."
    ),

    PackingListItemCategory(
        name: "Outdoor",
        icon: CategoryIcon.outdoor.rawValue,
        categoryDescribtion: "Ausrüstung für Wanderungen und Outdoor-Aktivitäten."
    ),

    PackingListItemCategory(
        name: "Accessoires",
        icon: CategoryIcon.accessories.rawValue,
        categoryDescribtion: "Zusätzliche Gegenstände und persönliche Accessoires."
    ),

    PackingListItemCategory(
        name: "Musik",
        icon: CategoryIcon.music.rawValue,
        categoryDescribtion: "Kopfhörer und musikalisches Zubehör."
    )

]
