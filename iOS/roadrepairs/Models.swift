import Foundation

struct Repair: Identifiable, Codable, Equatable {
    let id: UUID
    var repairDescription: String
    var location: String
    var cost: Double
    var date: Date
    var notes: String

    init(id: UUID = UUID(), repairDescription: String, location: String, cost: Double, date: Date, notes: String) {
        self.id = id
        self.repairDescription = repairDescription
        self.location = location
        self.cost = cost
        self.date = date
        self.notes = notes
    }
}
