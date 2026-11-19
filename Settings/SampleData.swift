//
//  SampleData.swift
//  123Pack
//
//  Created by Oliver Hartmann on 03.11.26.
//

import Foundation
import SwiftData

struct SampleData {

    static func create(in modelContext: ModelContext) {

        // MARK: - Categories

        let clothing = Category(
            name: "Clothing",
            icon: "tshirt",
            details: "Clothing and accessories"
        )

        let hygiene = Category(
            name: "Hygiene",
            icon: "shower",
            details: "Personal hygiene"
        )

        modelContext.insert(clothing)
        modelContext.insert(hygiene)


        // MARK: - Items

        let tshirt = Item(
            name: "T-Shirt",
            defaultQuantity: 2,
            details: "Basic T-Shirt",
            category: clothing
        )

        let pullover = Item(
            name: "Pullover",
            defaultQuantity: 1,
            details: "Warm pullover",
            category: clothing
        )

        let trousers = Item(
            name: "Trousers",
            defaultQuantity: 2,
            details: "Comfortable trousers",
            category: clothing
        )

        let toothbrush = Item(
            name: "Toothbrush",
            defaultQuantity: 1,
            details: "Manual toothbrush",
            category: hygiene
        )

        let shampoo = Item(
            name: "Shampoo",
            defaultQuantity: 1,
            details: "Travel size shampoo",
            category: hygiene
        )

        let sampleItems: [Item] = [
            tshirt,
            pullover,
            trousers,
            toothbrush,
            shampoo
        ]

        for item in sampleItems {
            modelContext.insert(item)
        }


        // MARK: - Packing Lists

        let packingList1: [PackingList] = [
            PackingList(item: tshirt, quantity: 3, isPacked: true),
            PackingList(item: pullover, quantity: 1, isPacked: true),
            PackingList(item: toothbrush, quantity: 1, isPacked: false)
        ]

        let packingList2: [PackingList] = [
            PackingList(item: tshirt, quantity: 2, isPacked: false),
            PackingList(item: trousers, quantity: 2, isPacked: false),
            PackingList(item: toothbrush, quantity: 1, isPacked: false),
            PackingList(item: shampoo, quantity: 1, isPacked: true)
        ]


        // MARK: - Trips

        let trip1 = Trip(
            name: "Japan Backpacking",
            details: "From Tokyo to Hiroshima mit dem Shinkansen. What a Fun!",
            startDate: Calendar.current.date(
                from: DateComponents(year: 2026, month: 10, day: 22)
            )!,
            endDate: Calendar.current.date(
                from: DateComponents(year: 2026, month: 11, day: 8)
            )!,
            image: TripIcon.airplane.rawValue,
            packingList: packingList1

        )

        let trip2 = Trip(
            name: "Thailand Backpacking",
            details: "Endlich wieder in die Sonne. Bangkok und Koh Phangan",
            startDate: Calendar.current.date(
                from: DateComponents(year: 2027, month: 5, day: 10)
            )!,
            endDate: Calendar.current.date(
                from: DateComponents(year: 2027, month: 5, day: 24)
            )!,
            image: TripIcon.airplane.rawValue,
            packingList: packingList2
        )

        modelContext.insert(trip1)
        modelContext.insert(trip2)

        do {
            try modelContext.save()
            print("Sample Data successfully saved!")
        } catch {
            print("SwiftData save error: \(error.localizedDescription)")
        }
    }
}
