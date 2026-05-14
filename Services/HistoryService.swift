import Foundation

class HistoryService {

    static let shared = HistoryService()

    private let key = "prediction_history"

    func save(item: HistoryItem) {

        var history = fetchHistory()

        history.insert(item, at: 0)

        if history.count > 10 {
            history.removeLast()
        }

        if let encoded = try? JSONEncoder().encode(history) {

            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func fetchHistory() -> [HistoryItem] {

        guard
            let data = UserDefaults.standard.data(forKey: key),
            let decoded = try? JSONDecoder().decode(
                [HistoryItem].self,
                from: data
            )
        else {

            return []
        }

        return decoded
    }
}
