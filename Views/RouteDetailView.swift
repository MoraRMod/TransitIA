import SwiftUI

struct RouteDetailView: View {

    let route: BusRoute

    var saturationColor: Color {

        switch route.saturation {

        case "Alta":
            return .red

        case "Media":
            return .orange

        default:
            return .green
        }
    }

    var recommendation: String {

        switch route.saturation {

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

                Image(systemName: "bus.doubledecker.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.white)

                Text(route.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                VStack(spacing: 20) {

                    VStack {

                        Text("Tiempo estimado")
                            .font(.headline)

                        Text(route.waitTime)
                            .font(.system(size: 45))
                            .bold()
                    }

                    Divider()

                    VStack {

                        Text("Nivel de saturación")
                            .font(.headline)

                        Text(route.saturation)
                            .font(.title)
                            .bold()
                            .foregroundColor(saturationColor)
                    }

                    Divider()

                    VStack {

                        Text("Recomendación")
                            .font(.headline)

                        Text(recommendation)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
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
