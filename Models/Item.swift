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
    
    var name: String
    var quantity: Int
   // var image: Data?
  // var icon: String
    var details: String?
    var isPacked: Bool
    var category: Category
    

    init(name: String,
         quantity: Int,
        // image: Data?,
        // icon: String,
         details: String?,
         isPacked: Bool,
         category: Category

    ) {
        self.name = name
        self.quantity = quantity
      //  self.image = image
      //  self.icon = icon.rawValue
        self.details = details
        self.isPacked = isPacked
        self.category = category
    }
    
}

let exampleItems: [Item] = [

    Item(
        name: "T-Shirts",
        quantity: 3,
      //  icon: ItemIcon.tshirt,
        details: "Leichte, schnell trocknende Shirts",
        isPacked: true,
        category: exampleCategories[0]
    )

]
