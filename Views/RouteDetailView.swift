import SwiftUI

struct RouteDetailView: View {

    let route: BusRoute

    @State private var selectedHour = 7
    @State private var selectedTraffic = "Alta"
    @State private var selectedDay = "Lunes"

    let trafficOptions = ["Alta", "Media", "Baja"]

    let days = [
        "Lunes",
        "Martes",
        "Miercoles",
        "Jueves",
        "Viernes",
        "Sabado",
        "Domingo"
    ]

    var prediction: String {

        PredictionService.shared.predictSaturation(
            hour: selectedHour,
            day: selectedDay,
            traffic: selectedTraffic
        )
    }

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
            return "Alta demanda detectada. Se recomienda esperar otra unidad."

        case "Media":
            return "El transporte presenta una saturación moderada."

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

            ScrollView {

                VStack(spacing: 25) {

                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 80))
                        .foregroundColor(.white)

                    Text(route.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    VStack(spacing: 20) {

                        // Hora
                        VStack(alignment: .leading) {

                            Text("Hora")
                                .font(.headline)

                            Stepper(
                                "\(selectedHour):00 hrs",
                                value: $selectedHour,
                                in: 0...23
                            )
                        }

                        Divider()

                        // Día
                        VStack(alignment: .leading) {

                            Text("Día")
                                .font(.headline)

                            Picker("Día", selection: $selectedDay) {

                                ForEach(days, id: \.self) { day in
                                    Text(day)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }

                        Divider()

                        // Tráfico
                        VStack(alignment: .leading) {

                            Text("Nivel de tráfico")
                                .font(.headline)

                            Picker(
                                "Tráfico",
                                selection: $selectedTraffic
                            ) {

                                ForEach(trafficOptions, id: \.self) {
                                    traffic in

                                    Text(traffic)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }

                        Divider()

                        // Predicción
                        VStack {

                            Text("Predicción IA")
                                .font(.headline)

                            Text(prediction)
                                .font(.system(size: 40))
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

                            Text("Recomendación")
                                .font(.headline)

                            Text(recommendation)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                        }

                        Divider()

                        VStack {

                            Text("Tecnología")
                                .font(.headline)

                            Text("Predicción generada con Core ML")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(25)
                    .padding(.horizontal)

                    Spacer()
                }
                .padding(.top, 30)
                
                .onAppear {

                    let item = HistoryItem(
                        routeName: route.name,
                        prediction: prediction,
                        hour: selectedHour,
                        day: selectedDay
                    )

                    HistoryService.shared.save(item: item)
                }
            }
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
