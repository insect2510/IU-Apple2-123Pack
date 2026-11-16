import SwiftData
import SwiftUI

struct AllTripsView: View {

    @Environment(\.modelContext) private var modelContext

    @Query private var categories: [Category]
    @Query private var items: [Item]
    @Query private var trips: [Trip]
    @State private var showNewItemView = false
    @State private var showNewTripView = false

    var body: some View {
        
        // MARK: - MAIN

        ZStack {
            Colors.backgroundcolor
            //    .ignoresSafeArea()
            
            NavigationStack {

                List {

                    tripSection
                    
                    // MARK: - Create Sample Data
                    
                    SecondaryButton(
                        title: "Create Sample Data",
                        icon: "plus"
                    ) {
                        SampleData.create(in: modelContext)
                    }
                    .disabled(!trips.isEmpty)
                    

                    // MARK: - Buttons for New

                    HStack(spacing: 16) {

                        PrimaryButton(
                            title: "Create New Trip",
                            icon: "plus"
                        ) {
                            showNewTripView = true
                        }
                    
                        Spacer()
                        
                        PrimaryButton(
                            title: "Create New Item",
                            icon: "plus"
                        ) {
                            showNewItemView = true
                        }
                    
                    }
                    .listRowBackground(Color.clear)
                }
                
                .navigationTitle("Trips")
                .navigationBarTitleDisplayMode(.large)
                
                
                // MARK: Sheet für NewTripView

                .sheet(isPresented: $showNewTripView) {
                    NewTripView()
                }
                

                // MARK: Sheet für NewItemView

                .sheet(isPresented: $showNewItemView) {
                    NewItemView()
                }
                .padding(0)
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
    AllTripsView()
}
