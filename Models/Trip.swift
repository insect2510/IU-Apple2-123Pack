//
//  Trip.swift
//  123Pack
//

import Foundation
import SwiftData

@Model
class Trip {

    var name: String
    var details: String?
    var startDate: Date?
    var endDate: Date?
    var image: String?

    @Relationship(deleteRule: .cascade)
    var packingList: [PackingList] = []

    init(
        name: String,
        details: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        image: String? = nil,
        packingList: [PackingList] = []
    ) {
        self.name = name
        self.details = details
        self.startDate = startDate
        self.endDate = endDate
        self.image = image
        self.packingList = packingList
    }
}
