import Foundation
import SwiftUI

struct TransitLine: Identifiable {

    let id = UUID()

    let name: String
    let type: String
    let color: Color
    let stations: [String]
}
