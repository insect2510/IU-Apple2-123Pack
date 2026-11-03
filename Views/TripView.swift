
import SwiftUI
import SwiftData

struct TripView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var categories: [Category]
    @Query private var items: [Item]
    @Query private var trips: [Trip]
    @State private var showNewItemView = false
    
    var body: some View {
        
    
        // MARK: - Header
        HeaderView()
        
        NavigationStack {
            
            List {
                
                tripSection
                itemSection
                categorySection
                
                // MARK: - Create Sample Data
                
               Button("Create Sample Data") {
                    SampleData.create(in: modelContext)
                }
                .disabled(!trips.isEmpty)
                
                
                Button {
                    showNewItemView = true
                } label: {
                    Label("Create New Item", systemImage: "plus")
                }
            }
            .navigationTitle("Sample Data")
            
            
            // Sheet für NewItemView
            .sheet(isPresented: $showNewItemView) {
                NewItemView()
            }
        }
        
        // MARK: - Bottom Menu

        BottomMenuView()
    }
    
    
    // MARK: - Category Section
    
    private var categorySection: some View {
        Section("Categories (\(categories.count))") {
            
            ForEach(categories) { category in
                HStack {
                    Image(systemName: category.icon)
                    
                    VStack(alignment: .leading) {
                        Text(category.name)
                        Text(category.categoryDescribtion)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
    
    // MARK: - Item Section
    
    private var itemSection: some View {
        Section("Items (\(items.count))") {
            
            ForEach(items) { item in
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    
                    Text(item.category.name)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text("Default Quantity: \(item.defaultQuantity)")
                        .font(.caption)
                }
            }
        }
    }
    
    // MARK: - Trip Section
    
    private var tripSection: some View {
        Section("Trips (\(trips.count))") {
            
            ForEach(trips) { trip in
                CardTripView(trip: trip)
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
    TripView()
        
}
