import Foundation

struct TransitLine: Identifiable {

    let id = UUID()

    let name: String
    let type: String
    let color: String
    let stations: [String]
}
