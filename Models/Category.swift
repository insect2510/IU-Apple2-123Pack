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
