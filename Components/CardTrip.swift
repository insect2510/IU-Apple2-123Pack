//
//  CardTrip.swift
//  123Pack
//
//  Created by Oliver Hartmann on 18.09.26.
//

import Foundation
import SwiftUI
import SwiftData


// MARK: - Trip Card

struct CardTripView: View {
    
    let trip: Trip
    
    var body: some View {
        
        HStack(spacing: 8) {
            
            // MARK: Trip Icon
            
            Image(systemName: trip.image)
                .font(.largeTitle)
                .foregroundStyle(Colors.cardtextdcolor)
                .font(.system(size: 48))
                    .frame(width: 70, height: 70)
            
            // MARK: Trip Information
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(trip.name)
                    .font(.title2.bold())
                    .foregroundStyle(Colors.cardtextdcolor)
                
                // Date
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(Colors.cardtextdcolor)
                    
                    Text(dateRange)
                        .font(.subheadline)
                        .foregroundStyle(Colors.cardtextdcolor)
                }
                
                // Packing List Items
                
                HStack {
                    Image(systemName: "suitcase")
                        .foregroundStyle(Colors.cardtextdcolor)
                    
                    Text("\(trip.packingList.filter { $0.isPacked }.count)/\(trip.packingList.count) Items packed")
                        .font(.subheadline)
                        .foregroundStyle(Colors.cardtextdcolor)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Colors.cardbackgroundcolor)
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
    }
    
    // MARK: - Date Range
    
    private var dateRange: String {

        let start = AppDateFormatter.shared.format(trip.startDate)

        let end = AppDateFormatter.shared.format(trip.endDate)

        return "\(start) – \(end)"
    }
}

// MARK: - Preview

#Preview {
    CardTripView(
        trip: Trip(
            name: "Thailand Backpacking",
            startDate: Calendar.current.date(
                from: DateComponents(
                    year: 2026,
                    month: 10,
                    day: 15
                )
            )!,
            endDate: Calendar.current.date(
                from: DateComponents(
                    year: 2026,
                    month: 11,
                    day: 12
                )
            )!,
            image: TripIcon.holiday.rawValue
        )
    )
    .padding()
    .modelContainer(
        for: [
            Trip.self,
            PackingList.self
        ],
        inMemory: true
    )
}
