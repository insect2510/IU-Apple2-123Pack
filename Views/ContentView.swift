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
}

// MARK: - Preview

#Preview {
    ContentView()

}
