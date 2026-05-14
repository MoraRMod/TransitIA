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
        BusRoute(name: "Macro Periférico", waitTime: "2 min", saturation: "Baja"),
        BusRoute(name: "Ruta 24", waitTime: "10 min", saturation: "Alta")
    ]

    var body: some View {

        NavigationView {

            ZStack {

                LinearGradient(
                    colors: [.blue.opacity(0.7), .cyan.opacity(0.4)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {

                    VStack(spacing: 20) {

                        Text("TransitIA")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top)

                        Text("Consulta tiempos y saturación del transporte público")
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        ForEach(routes) { route in

                            NavigationLink(destination: RouteDetailView(route: route)) {

                                RouteCardView(route: route)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
