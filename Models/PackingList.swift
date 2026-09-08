//
//  PackingList.swift
//  123Pack
//
//  Created by Oliver Hartmann on 08.09.26.
//

//
//  Trip.swift
//  123Pack
//
//  Created by Oliver Hartmann on 08.09.26.
//



import Foundation
import SwiftData

@Model
class PackingList {
    
    var name: String
    var createdAt: Date?
    var categories: [PackingListCategory]
    var items: [PackingListItem]

    
    init(name: String,
         createdAt: Date? = nil,
         categories: [PackingListCategory] = [],
         items: [PackingListItem] = [],

    ) {
        self.name = name
        self.createdAt = createdAt
        self.categories = categories
        self.items = items
    }
    
}
