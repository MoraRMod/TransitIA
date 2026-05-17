import SwiftUI

struct StationDetailView: View {

    let line: TransitLine
    let station: String

    @State private var selectedHour = 8
    @State private var selectedTraffic = "Alta"
    @State private var selectedDay = "Lunes"

    @State private var direction = 0

    let trafficOptions = ["Alta", "Media", "Baja"]

    let days = [
        "Lunes",
        "Martes",
        "Miércoles",
        "Jueves",
        "Viernes",
        "Sábado",
        "Domingo"
    ]

    var terminals: [String] {

        guard
            let first = line.stations.first,
            let last = line.stations.last
        else {
            return []
        }

        return [first, last]
    }

    var currentIndex: Int {

        line.stations.firstIndex(of: station) ?? 0
    }

    var remainingStations: Int {

        if direction == 0 {

            return currentIndex

        } else {

            return (line.stations.count - 1) - currentIndex
        }
    }

    var destination: String {

        terminals[direction]
    }

    var prediction: String {

        PredictionService.shared.predictSaturation(
            hour: selectedHour,
            day: selectedDay,
            traffic: selectedTraffic
        )
    }

    var arrivalTime: Int {

        switch prediction {

        case "Alta":
            return max(2, remainingStations / 2)

        case "Media":
            return max(3, remainingStations / 2)

        default:
            return max(4, remainingStations / 2)
        }
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

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [.purple.opacity(0.7), .blue.opacity(0.4)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {

                VStack(spacing: 20) {

                    Text(station)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Text(line.name)
                        .foregroundColor(.white)

                    VStack(spacing: 20) {

                        VStack(alignment: .leading) {

                            Text("Dirección")
                                .font(.headline)

                            Picker(
                                "Dirección",
                                selection: $direction
                            ) {

                                Text(terminals[0])
                                    .tag(0)

                                Text(terminals[1])
                                    .tag(1)
                            }
                            .pickerStyle(.segmented)
                        }

                        Divider()

                        Stepper(
                            "Hora: \(selectedHour):00 hrs",
                            value: $selectedHour,
                            in: 0...23
                        )

                        Divider()

                        VStack(alignment: .leading) {

                            Text("Nivel de tráfico")
                                .font(.headline)

                            Picker(
                                "Tráfico",
                                selection: $selectedTraffic
                            ) {

                                ForEach(
                                    trafficOptions,
                                    id: \.self
                                ) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }

                        Divider()

                        VStack(alignment: .leading) {

                            Text("Día")
                                .font(.headline)

                            Picker(
                                "Día",
                                selection: $selectedDay
                            ) {

                                ForEach(days, id: \.self) {

                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                        }

                        Divider()

                        VStack(spacing: 10) {

                            Text("Destino")
                                .font(.headline)

                            Text(destination)
                                .font(.title2)
                                .bold()
                        }

                        Divider()

                        VStack(spacing: 10) {

                            Text("Estaciones restantes")
                                .font(.headline)

                            Text("\(remainingStations)")
                                .font(.system(size: 35))
                                .bold()
                                .foregroundColor(.blue)
                        }

                        Divider()

                        VStack(spacing: 10) {

                            Text("Próxima unidad")
                                .font(.headline)

                            Text("\(arrivalTime) min")
                                .font(.system(size: 40))
                                .bold()
                                .foregroundColor(.blue)
                        }

                        Divider()

                        VStack(spacing: 10) {

                            Text("Predicción IA")
                                .font(.headline)

                            Text(prediction)
                                .font(.title)
                                .bold()
                                .foregroundColor(saturationColor)
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(25)
                }
                .padding()
            }
        }
    }
}

#Preview {

    StationDetailView(
        line: TransitLine(
            name: "Línea 1",
            type: "Tren Ligero",
            color: "red",
            stations: [
                "Auditorio",
                "Periférico Norte",
                "Juárez",
                "Periférico Sur"
            ]
        ),
        station: "Juárez"
    )
}
