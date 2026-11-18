//
//  Untitled.swift
//  123Pack
//
//  Created by Oliver Hartmann on 01.11.26.
//


import Foundation
import SwiftData

@Model
class PackingList {

    var item: Item
    var quantity: Int
    var isPacked: Bool

    init(
        item: Item,
        quantity: Int = 1,
        isPacked: Bool = false
    ) {
        self.item = item
        self.quantity = quantity
        self.isPacked = isPacked
    }
}
