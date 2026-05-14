import SwiftUI

struct BusRoute: Identifiable {
    let id = UUID()
    let name: String
    let waitTime: String
    let saturation: String
}

struct ContentView: View {

    let routes = [
        BusRoute(name: "Ruta 380", waitTime: "8 min", saturation: "Alta"),
        BusRoute(name: "Ruta 622", waitTime: "5 min", saturation: "Media"),
        BusRoute(name: "Macro Periférico", waitTime: "2 min", saturation: "Baja")
    ]

    var body: some View {

        NavigationView {

            List(routes) { route in

                NavigationLink(destination: RouteDetailView(route: route)) {

                    VStack(alignment: .leading) {

                        Text(route.name)
                            .font(.headline)

                        Text("Tiempo estimado: \(route.waitTime)")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("TransitIA")
        }
    }
}

#Preview {
    ContentView()
}
