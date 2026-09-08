//
//  PackingListCategory.swift
//  123Pack
//
//  Created by Oliver Hartmann on 08.09.26.
//

import Foundation
import SwiftData

@Model
class PackingListCategory {
    
    var name: String
    var icon: String
    var categoryDescribtion: String

    init(name: String,
         icon: String,
         categoryDescribtion: String

    ) {
        self.name = name
        self.icon = icon
        self.categoryDescribtion = categoryDescribtion
    }
    
}
