//
//  Trip.swift
//  123Pack
//
//  Created by Oliver Hartmann on 08.09.26.
//



import Foundation
import SwiftData

@Model
class Trip {
    
    var name: String
    var startDate: Date?
    var endDate: Date?
    var image: String?
    
    @Relationship(deleteRule: .cascade)
    var packingList: PackingList?
    
    init(name: String,
         startDate: Date? = nil,
         endDate: Date? = nil,
         image: String? = nil,
         packingList: PackingList? = nil
    ) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.image = image
        self.packingList = packingList
    }
    
}

let thailandTrip = Trip(
    name: "Thailand Backpacking",
    startDate: Calendar.current.date(
        from: DateComponents(year: 2026, month: 10, day: 15)
    ),
    endDate: Calendar.current.date(
        from: DateComponents(year: 2026, month: 11, day: 12)
    ),
    image: TripIcon.airplane.rawValue
)

let portugalTrip = Trip(
    name: "Portugal Backpacking",
    startDate: Calendar.current.date(
        from: DateComponents(year: 2027, month: 5, day: 10)
    ),
    endDate: Calendar.current.date(
        from: DateComponents(year: 2027, month: 5, day: 24)
    ),
    image: TripIcon.globe.rawValue
)

let exampleTrips: [Trip] = [
    thailandTrip,
    portugalTrip
]
