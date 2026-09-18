//
//  ContentView.swift
//  123Pack
//
//  Created by Oliver Hartmann on 03.09.26.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    // SwiftData
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Logo + Title
            
            HeaderView()
            
            
            ScrollView  {
                
                VStack(spacing: 20) {
                    
                    // MARK: - Trips

                    if trips.isEmpty {
                        ContentUnavailableView(
                            "Keine Trips vorhanden",
                            systemImage: "backpack",
                            description: Text("Füge einen neuen Trip hinzu.")
                        )
                    } else {
                        ForEach(trips) { trip in
                            TripCardView(trip: trip)
                        }
                    }

                    // MARK: - Add new trip

                    Button {
                        // Button to add a new trip
                    } label: {
                        HStack {

                            RoundedRectangle(cornerRadius: 12)
                                .fill(Colors.cardcolor.opacity(0.2))
                                .frame(width: 100, height: 100)
                                .overlay {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(Colors.cardcolor)
                                }

                            Text("Trip hinzufügen")
                                .font(.headline)
                                .foregroundStyle(Colors.primarycolor)

                            Spacer()
                        }
                        .padding()
                    }
                    .buttonStyle(.plain)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )

                    Spacer()
                }
               .padding()
                    
                }

              
            .background(Colors.backgroundcolor)
            .task {
                addExampleTrips()
            }
                
            }
            
            
        
        // Unteres Menü
               BottomMenuView()
    }

    // MARK: - Add Example Trips

    private func addExampleTrips() {

        // Keine Beispieldaten hinzufügen,
        // wenn bereits Trips existieren.
        guard trips.isEmpty else { return }

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

        let japanTrip = Trip(
            name: "Japan Backpacking",
            startDate: Calendar.current.date(
                from: DateComponents(year: 2027, month: 9, day: 5)
            ),
            endDate: Calendar.current.date(
                from: DateComponents(year: 2027, month: 9, day: 26)
            ),
            image: TripIcon.map.rawValue
        )

        let norwayTrip = Trip(
            name: "Norwegen Roadtrip",
            startDate: Calendar.current.date(
                from: DateComponents(year: 2028, month: 6, day: 1)
            ),
            endDate: Calendar.current.date(
                from: DateComponents(year: 2028, month: 6, day: 15)
            ),
            image: TripIcon.tent.rawValue
        )

        modelContext.insert(thailandTrip)
        modelContext.insert(portugalTrip)
        modelContext.insert(japanTrip)
        modelContext.insert(norwayTrip)
    }
}


// MARK: - Trip Card

struct TripCardView: View {

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

#Preview {
    ContentView()
        .modelContainer(
            for: [
                Trip.self,
                PackingList.self
            ],
            inMemory: true
        )
}
