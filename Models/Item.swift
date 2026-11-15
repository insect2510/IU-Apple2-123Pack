//
//  PackingListItem.swift
//  123Pack
//
//  Created by Oliver Hartmann on 08.09.26.
//

import Foundation
import SwiftData

@Model
class Item {
    
    @Attribute(.unique)
    var id: UUID
    
    var name: String
    var defaultQuantity: Int
    var details: String?
    var category: Category
    

    init(
        id: UUID = UUID(),
        name: String,
         defaultQuantity: Int,
         details: String?,
         category: Category

    ) {
        self.id = id
        self.name = name
        self.defaultQuantity = defaultQuantity
        self.details = details
        self.category = category
    }
    
}

