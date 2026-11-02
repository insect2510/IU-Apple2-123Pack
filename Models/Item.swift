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
   // var image: Data?
  // var icon: String
    var details: String?
    var isPacked: Bool
    var isAutoAdd: Bool
    var category: Category
    

    init(
        id: UUID = UUID(),
        name: String,
         defaultQuantity: Int,
        // image: Data?,
        // icon: String,
         details: String?,
         isPacked: Bool,
         isAutoAdd: Bool,
         category: Category

    ) {
        self.id = id
        self.name = name
        self.defaultQuantity = defaultQuantity
      //  self.image = image
      //  self.icon = icon.rawValue
        self.details = details
        self.isPacked = isPacked
        self.isAutoAdd = isAutoAdd
        self.category = category
    }
    
}

