import SwiftUI

struct RouteDetailView: View {

    let route: BusRoute

    // Predicción usando Core ML
    let prediction = PredictionService.shared.predictSaturation(
        hour: 18,
        day: "Lunes",
        traffic: "Alta"
    )

    var saturationColor: Color {

        switch prediction {

        case "Alta":
            return .red

        case "Media":
            return .orange

        default:
            return .green
        }
    }

    var recommendation: String {

        switch prediction {

        case "Alta":
            return "Se recomienda esperar la siguiente unidad."

        case "Media":
            return "Saturación moderada."

        default:
            return "La unidad presenta baja saturación."
        }
    }

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [.blue.opacity(0.8), .cyan.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 25) {

                Image(systemName: "brain.head.profile")
                    .font(.system(size: 80))
                    .foregroundColor(.white)

                Text(route.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                VStack(spacing: 20) {

                    VStack {

                        Text("Predicción IA")
                            .font(.headline)

                        Text(prediction)
                            .font(.system(size: 45))
                            .bold()
                            .foregroundColor(saturationColor)
                    }

                    Divider()

                    VStack {

                        Text("Tiempo estimado")
                            .font(.headline)

                        Text(route.waitTime)
                            .font(.title)
                            .bold()
                    }

                    Divider()

                    VStack {

                        Text("Análisis")
                            .font(.headline)

                        Text(recommendation)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    }

                    Divider()

                    VStack {

                        Text("Tecnología")
                            .font(.headline)

                        Text("Predicción generada mediante Core ML")
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(25)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    RouteDetailView(
        route: BusRoute(
            name: "Ruta 380",
            waitTime: "8 min",
            saturation: "Alta"
        )
    )
}
