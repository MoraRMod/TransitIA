internal import CoreData

struct PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {

        container = NSPersistentContainer(
            name: "TransitIADataModel"
        )

        container.loadPersistentStores {
            _, error in

            if let error = error {

                fatalError(
                    "Core Data error: \(error)"
                )
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
