import Foundation
internal import CoreData

class HistoryService {

    static let shared = HistoryService()

    private let context =
        PersistenceController
            .shared
            .container
            .viewContext

    func savePrediction(
        line: String,
        station: String,
        destination: String,
        prediction: String,
        hour: Int,
        day: String,
        estimatedTime: Int
    ) {

        let item = PredictionEntity(
            context: context
        )

        item.id = UUID()
        item.fecha = Date()
        item.linea = line
        item.estacion = station
        item.direccion = destination
        item.prediccion = prediction
        item.horaConsulta = Int16(hour)
        item.dia = day
        item.tiempoEstimado = Int16(
            estimatedTime
        )

        do {

            try context.save()

        } catch {

            print(
                "Error guardando historial: \(error)"
            )
        }
    }

    func fetchHistory()
    -> [PredictionEntity] {

        let request:
        NSFetchRequest<
            PredictionEntity
        > = PredictionEntity.fetchRequest()

        request.sortDescriptors = [
            NSSortDescriptor(
                key: "fecha",
                ascending: false
            )
        ]

        do {

            return try context.fetch(
                request
            )

        } catch {

            print(
                "Error cargando historial: \(error)"
            )

            return []
        }
    }

    func clearHistory() {

        let request:
        NSFetchRequest<
            NSFetchRequestResult
        > = PredictionEntity
            .fetchRequest()

        let delete =
            NSBatchDeleteRequest(
                fetchRequest: request
            )

        do {

            try context.execute(
                delete
            )

            try context.save()

        } catch {

            print(
                "Error borrando historial"
            )
        }
    }
}
