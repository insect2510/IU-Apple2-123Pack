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

    @Attribute(.unique)
    var id: UUID

    var itemID: UUID
    var quantity: Int

    init(
        id: UUID = UUID(),
        itemID: UUID,
        quantity: Int = 1
    ) {
        self.id = id
        self.itemID = itemID
        self.quantity = quantity
    }
}
