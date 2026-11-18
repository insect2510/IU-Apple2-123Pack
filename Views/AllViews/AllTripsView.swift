import SwiftData
import SwiftUI

struct AllTripsView: View {

    @Environment(\.modelContext) private var modelContext

    @Query private var categories: [Category]
    @Query private var items: [Item]
    @Query private var trips: [Trip]
    
    // sheet modifier for buttons
    
    enum ActiveSheet: Identifiable {
        case newTrip
        case newItem

        var id: Self { self }
    }
    
    @State private var activeSheet: ActiveSheet?

    var body: some View {
        
        // MARK: - MAIN

        ZStack {
            
            Colors.backgroundcolor
            
            NavigationStack {

                List {

                    tripSection
                    
                    // MARK: - Create Sample Data
                    
                    PrimaryButton(
                        title: "Create Sample Data",
                        icon: NavIcons.new.rawValue
                    ) {
                        SampleData.create(in: modelContext)
                    }
                    .disabled(!trips.isEmpty)
                    

                    // MARK: - Button for New Trip and Item

                    HStack(spacing: 16) {

                        PrimaryButton(
                            title: "New Trip",
                            icon: NavIcons.new.rawValue
                        ) {
                            activeSheet = .newTrip
                        }
                    
                        Spacer()
                        
                        PrimaryButton(
                            title: "New Item",
                            icon: NavIcons.new.rawValue
                        ) {
                            activeSheet = .newItem
                        }
                    
                    }
                    .listRowBackground(Color.clear)
                }
                .navigationTitle("Trips")
                .navigationBarTitleDisplayMode(.large)
                .scrollContentBackground(.hidden)
            }

        }
        .preferredColorScheme(.light)
        
        // MARK: Sheet für NewTripView / NewItemView

        .sheet(item: $activeSheet) { sheet in

            NavigationStack {

                switch sheet {

                case .newTrip:
                    NewTripView()

                case .newItem:
                    NewItemView()
                }
            }
        }
        .padding(0)
        
    }
    

    // MARK: - Trip Section

    private var tripSection: some View {
        
        Section("Trips (\(trips.count))") {

            ForEach(trips) { trip in

                NavigationLink {
                    SingleTripView(trip: trip)
                } label: {
                    CardTripView(trip: trip)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    AllTripsView()
}
