import Foundation

struct HistoryItem: Identifiable, Codable {

    var id = UUID()

    let routeName: String
    let prediction: String
    let hour: Int
    let day: String
}
