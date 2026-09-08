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



