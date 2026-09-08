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
    var note: String?
    var isPacked: BooleanLiteralType
    var category: PackingListCategory
    

    init(name: String,
         quantity: Int,
         image: Data?,
         note: String?,
         isPacked: Bool,
         category: PackingListCategory

    ) {
        self.name = name
        self.quantity = quantity
        self.image = image
        self.note = note
        self.isPacked = isPacked
        self.category = category
    }
    
}
