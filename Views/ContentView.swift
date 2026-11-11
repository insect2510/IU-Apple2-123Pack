import SwiftData
import SwiftUI

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext

    @Query private var categories: [Category]
    @Query private var items: [Item]
    @Query private var trips: [Trip]
    @State private var showNewItemView = false
    @State private var showNewTripView = false

    var body: some View {

        // MARK: - Header
        Menu1Header()
        
        // MARK: - MAIN

        ZStack {
            Colors.backgroundcolor
                .ignoresSafeArea()
            
            NavigationStack {

                List {

                    tripSection
                    
                    // MARK: - Create Sample Data

                    Button {
                        SampleData.create(in: modelContext)
                    } label: {
                        Label("Create Sample Data", systemImage: "plus")
                        
                    }
                    .disabled(!trips.isEmpty)

                    // MARK: - Buttons for New

                    HStack(spacing: 16) {
                        
                        Button {
                            showNewTripView = true
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .medium))

                                Text("Create New Trip")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundStyle(Colors.buttontextcolor)
                            .frame(width: 140, height: 100)
                            .background(Colors.buttonbackgroundcolor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .buttonStyle(.plain)

                        Button {
                            showNewItemView = true
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .medium))

                                Text("Create New Item")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundStyle(Colors.buttontextcolor)
                            .frame(width: 140, height: 100)
                            .background(Colors.buttonbackgroundcolor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        }
                        .buttonStyle(.plain)


                    }
                    .listRowBackground(Color.clear)
                }
                

                // MARK: Sheet für NewItemView

                .sheet(isPresented: $showNewItemView) {
                    NewItemView()
                }
                .padding(0)

                
                // MARK: Sheet für NewTripView

                .sheet(isPresented: $showNewTripView) {
                    NewTripView()
                }

                // MARK: - Bottom Menu

                Menu2Bottom()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)

        }
        .preferredColorScheme(.light)
        
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

    // MARK: - Separate Trip Row View

    struct TripRowView: View {

        let trip: Trip
        let items: [Item]

        var body: some View {

            VStack(alignment: .leading, spacing: 8) {

                Text(trip.name)
                    .font(.headline)

                ForEach(trip.packingList, id: \.id) { entry in
                    packingListItemRow(entry)
                }
            }
            .padding(.vertical, 4)
        }

        @ViewBuilder
        private func packingListItemRow(_ entry: PackingList) -> some View {

            if let item = items.first(where: { $0.id == entry.itemID }) {

                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)

                        Text(item.category.name)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Text("\(entry.quantity) x")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()

}
