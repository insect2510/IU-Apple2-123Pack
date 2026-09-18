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

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }

    var body: some View {
        HStack(spacing: 16) {

            // MARK: Trip Icon

            RoundedRectangle(cornerRadius: 12)
                .fill(Colors.carddarkcolor.opacity(0.5))
                .frame(width: 100, height: 100)
                .overlay {
                    Image(systemName: trip.image ?? "photo")
                        .font(.largeTitle)
                        .foregroundStyle(Colors.primarycolor)
                }

            // MARK: Trip Information

            VStack(alignment: .leading, spacing: 8) {

                Text(trip.name)
                    .font(.title2.bold())

                // Date
                HStack {
                    Image(systemName: "calendar")

                    Text(dateRange)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                // Packing List
                HStack {
                    Image(systemName: "suitcase")

                    Text(
                        trip.packingList == nil
                        ? "Keine Packliste"
                        : "Packliste vorhanden"
                    )
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
            }

            Spacer()
        }
        .padding()
        .background(Colors.cardcolor)
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
        .shadow(radius: 2)
    }

    // MARK: - Date Range

    private var dateRange: String {

        let start = trip.startDate.map {
            dateFormatter.string(from: $0)
        } ?? "–"

        let end = trip.endDate.map {
            dateFormatter.string(from: $0)
        } ?? "–"

        return "\(start) – \(end)"
    }
}

// MARK: - Preview

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
            ),
            endDate: Calendar.current.date(
                from: DateComponents(
                    year: 2026,
                    month: 11,
                    day: 12
                )
            ),
            image: TripIcon.airplane.rawValue
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
