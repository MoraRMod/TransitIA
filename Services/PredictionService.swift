import Foundation
import CoreML

class PredictionService {

    static let shared = PredictionService()

    private let model: TransitPredictor

    init() {

        do {
            model = try TransitPredictor(configuration: MLModelConfiguration())
        } catch {
            fatalError("Error cargando modelo: \\(error)")
        }
    }

    func predictSaturation(
        hour: Int,
        day: String,
        traffic: String
    ) -> String {

        do {

            let prediction = try model.prediction(
                hour: Int64(Double(hour)),
                day: day,
                traffic: traffic
            )

            return prediction.saturation

        } catch {

            return "Desconocida"
        }
    }
}
