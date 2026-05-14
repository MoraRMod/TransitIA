import Foundation

struct HistoryItem: Identifiable, Codable {

    let id = UUID()

    let routeName: String
    let prediction: String
    let hour: Int
    let day: String
}
