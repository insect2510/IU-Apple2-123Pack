//
//  PackingListItem.swift
//  123Pack
//
//  Created by Oliver Hartmann on 08.09.26.
//

import Foundation
import SwiftData

@Model
class PackingListItem {
    
    var name: String
    var quantity: Int
    var image: Data?
    var details: String?
    var isPacked: BooleanLiteralType
    var category: PackingListItemCategory
    

    init(name: String,
         quantity: Int,
        // image: Data?,
         icon: ItemIcon,
         note: String?,
         isPacked: Bool,
         category: PackingListItemCategory

    ) {
        self.name = name
        self.quantity = quantity
       // self.image = image
        self.icon = icon
        self.details = details
        self.isPacked = isPacked
        self.category = category
    }
    
}

let exampleItems: [PackingListItem] = [

    PackingListItem(
        name: "T-Shirts",
        quantity: 3,
        icon: ItemIcon.tshirt,
        note: "Leichte, schnell trocknende Shirts",
        isPacked: true,
        category: exampleCategories[0]
    )

]
