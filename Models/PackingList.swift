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
    var isPacked: Bool

    init(
        id: UUID = UUID(),
        itemID: UUID,
        quantity: Int = 1,
        isPacked: Bool = false
    ) {
        self.id = id
        self.itemID = itemID
        self.quantity = quantity
        self.isPacked = isPacked
    }
}
