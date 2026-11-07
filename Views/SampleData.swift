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
            categoryDescribtion: "Clothing and accessories"
        )

        let hygiene = Category(
            name: "Hygiene",
            icon: "shower",
            categoryDescribtion: "Personal hygiene"
        )

        modelContext.insert(clothing)
        modelContext.insert(hygiene)


        // MARK: - Items

        let tshirt = Item(
            name: "T-Shirt",
            defaultQuantity: 2,
            details: "Basic T-Shirt",
            isAutoAdd: true,
            category: clothing
        )

        let pullover = Item(
            name: "Pullover",
            defaultQuantity: 1,
            details: "Warm pullover",
            isAutoAdd: false,
            category: clothing
        )

        let trousers = Item(
            name: "Trousers",
            defaultQuantity: 2,
            details: "Comfortable trousers",
            isAutoAdd: true,
            category: clothing
        )

        let toothbrush = Item(
            name: "Toothbrush",
            defaultQuantity: 1,
            details: "Manual toothbrush",
            isAutoAdd: true,
            category: hygiene
        )

        let shampoo = Item(
            name: "Shampoo",
            defaultQuantity: 1,
            details: "Travel size shampoo",
            isAutoAdd: false,
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
            PackingList(itemID: tshirt.id, quantity: 3, isPacked: true),
            PackingList(itemID: pullover.id, quantity: 1, isPacked: true),
            PackingList(itemID: toothbrush.id, quantity: 1, isPacked: false)
        ]

        let packingList2: [PackingList] = [
            PackingList(itemID: tshirt.id, quantity: 2, isPacked: false),
            PackingList(itemID: trousers.id, quantity: 2, isPacked: false),
            PackingList(itemID: toothbrush.id, quantity: 1, isPacked: false),
            PackingList(itemID: shampoo.id, quantity: 1, isPacked: true)
        ]


        // MARK: - Trips

        let trip1 = Trip(
            name: "Japan Backpacking",
            details: "From Tokyo to Hiroshima mit dem Shinkansen. What a Fun!",
            startDate: Calendar.current.date(
                from: DateComponents(year: 2026, month: 10, day: 22)
            ),
            endDate: Calendar.current.date(
                from: DateComponents(year: 2026, month: 11, day: 8)
            ),
            packingList: packingList1
        )

        let trip2 = Trip(
            name: "Thailand Backpacking",
            details: "Endlich wieder in die Sonne. Bangkok und Koh Phangan",
            startDate: Calendar.current.date(
                from: DateComponents(year: 2027, month: 5, day: 10)
            ),
            endDate: Calendar.current.date(
                from: DateComponents(year: 2027, month: 5, day: 24)
            ),
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
