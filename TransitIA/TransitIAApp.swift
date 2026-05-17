import SwiftUI
internal import CoreData

@main
struct TransitIAApp: App {

    let persistenceController =
        PersistenceController.shared

    var body: some Scene {

        WindowGroup {

            ContentView()
                .environment(
                    \.managedObjectContext,
                    persistenceController
                        .container
                        .viewContext
                )
        }
    }
}
