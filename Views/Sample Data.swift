
import SwiftUI
import SwiftData

struct SampleDataView: View {

    @Environment(\.modelContext) private var modelContext

    @Query private var categories: [Category]
    @Query private var items: [Item]
    @Query private var trips: [Trip]
    @State private var showNewItemView = false
    
    var body: some View {

        NavigationStack {
            List {

                tripSection
                itemSection
                categorySection

                Button("Create Sample Data") {
                    createSampleData()
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
                TripRowView(trip: trip, items: items)
            }
        }
    }

    // MARK: - Create Sample Data

    private func createSampleData() {

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

        let tshirt = Item(
            name: "T-Shirt",
            defaultQuantity: 2,
            details: "Basic T-Shirt",
            isPacked: false,
            isAutoAdd: true,
            category: clothing
        )

        let pullover = Item(
            name: "Pullover",
            defaultQuantity: 1,
            details: "Warm pullover",
            isPacked: false,
            isAutoAdd: false,
            category: clothing
        )

        let trousers = Item(
            name: "Trousers",
            defaultQuantity: 2,
            details: "Comfortable trousers",
            isPacked: false,
            isAutoAdd: true,
            category: clothing
        )

        let toothbrush = Item(
            name: "Toothbrush",
            defaultQuantity: 1,
            details: "Manual toothbrush",
            isPacked: false,
            isAutoAdd: true,
            category: hygiene
        )

        let shampoo = Item(
            name: "Shampoo",
            defaultQuantity: 1,
            details: "Travel size shampoo",
            isPacked: false,
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

        // PackingList 1

        let packingList1: [PackingList] = [
            PackingList(itemID: tshirt.id, quantity: 3),
            PackingList(itemID: pullover.id, quantity: 1),
            PackingList(itemID: toothbrush.id, quantity: 1)
        ]

        // PackingList 2

        let packingList2: [PackingList] = [
            PackingList(itemID: tshirt.id, quantity: 2),
            PackingList(itemID: trousers.id, quantity: 2),
            PackingList(itemID: toothbrush.id, quantity: 1),
            PackingList(itemID: shampoo.id, quantity: 1)
        ]

        // Trips

        let trip1 = Trip(
            name: "Japan Backpacking",
            startDate: Calendar.current.date(
                from: DateComponents(year: 2026, month: 10, day: 22)
            ),
            endDate: Calendar.current.date(
                from: DateComponents(year: 2026, month: 11, day: 8)
            ),
            packingList: packingList1
        )

        let trip2 = Trip(
            name: "Portugal Backpacking",
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

        try? modelContext.save()
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
