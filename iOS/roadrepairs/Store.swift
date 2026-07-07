import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [Repair] = []
    @Published var isProUnlocked: Bool = false

    /// Free tier item cap. Deliberately kept above the seed data count
    /// so a fresh install never opens directly into the paywall.
    static let freeLimit = 8

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        self.fileURL = dir.appendingPathComponent("roadrepairs_items.json")
        load()
    }

    var canAddMore: Bool {
        isProUnlocked || items.count < Store.freeLimit
    }

    func add(_ item: Repair) {
        guard canAddMore else { return }
        items.append(item)
        save()
    }

    func update(_ item: Repair) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Repair) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([Repair].self, from: data) {
            items = decoded
        } else {
            items = [
        Repair(repairDescription: "Sample Repairdescription 1", location: "Sample Location 1", cost: 12.50, date: Date().addingTimeInterval(-259200), notes: "Sample Notes 1"),
        Repair(repairDescription: "Sample Repairdescription 2", location: "Sample Location 2", cost: 25.00, date: Date().addingTimeInterval(-518400), notes: "Sample Notes 2"),
        Repair(repairDescription: "Sample Repairdescription 3", location: "Sample Location 3", cost: 37.50, date: Date().addingTimeInterval(-777600), notes: "Sample Notes 3")
            ]
            save()
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }
}
