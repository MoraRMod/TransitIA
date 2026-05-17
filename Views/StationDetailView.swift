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
    
    var transfers: [String: [String]] {

        [
            "Independencia Norte":
                ["Línea 7"],

            "Periférico Norte":
                ["Línea 7"],

            "Periférico Sur":
                ["Línea 7"],

            "Periférico Belenes":
                ["Línea 7"],

            "Jalisco 200 Años":
                ["Línea 7", "Línea 4"],

            "Las Juntas":
                ["Línea 4"],

            "Carretera a Chapala":
                ["Línea 7"],

            "Agua Azul":
                ["Línea 5", "Línea 6"],

            "Fray Angélico":
                ["Línea 4"],

            "Juárez":
                ["Línea 2"],

            "Plaza Universidad":
                ["Línea 3"],

            "San Juan de Dios":
                ["Línea 6"],

            "Independencia":
                ["Línea 6"],

            "Bicentenario":
                ["Línea 3"],

            "Ávila Camacho":
                ["Línea 1", "Línea 3"]
        ]
    }

    var terminals: [String] {
        [
            line.stations.first ?? "",
            line.stations.last ?? ""
        ]
    }

    var currentIndex: Int {
        line.stations.firstIndex(of: station) ?? 0
    }

    var nextStation: String {

        if direction == 0 {

            return currentIndex > 0
            ? line.stations[currentIndex - 1]
            : "Terminal"

        } else {

            return currentIndex < line.stations.count - 1
            ? line.stations[currentIndex + 1]
            : "Terminal"
        }
    }

    var remainingStations: Int {

        if direction == 0 {
            return currentIndex
        }

        return (line.stations.count - 1) - currentIndex
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

    var serviceStatus: String {

        switch prediction {

        case "Alta":
            return "Demora moderada"

        case "Media":
            return "Servicio estable"

        default:
            return "Operando con normalidad"
        }
    }

    var arrivalTime: Int {

        if selectedHour >= 6 && selectedHour <= 9 {
            return Int.random(in: 2...4)
        }

        if selectedHour >= 17 && selectedHour <= 20 {
            return Int.random(in: 2...5)
        }

        return Int.random(in: 5...9)
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

        ScrollView {

            VStack(spacing: 24) {

                // Header

                VStack(spacing: 8) {

                    Circle()
                        .fill(line.color)
                        .frame(width: 70, height: 70)
                        .overlay {

                            Image(systemName: "tram.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }

                    Text(station)
                        .font(.largeTitle.bold())

                    Text(line.name)
                        .foregroundColor(.secondary)
                }
                .padding(.top)

                // Trayecto

                VStack(spacing: 18) {

                    routeInfoRow(
                        icon: "mappin.circle.fill",
                        title: "Estás en",
                        value: station
                    )

                    routeInfoRow(
                        icon: "flag.circle.fill",
                        title: "Destino",
                        value: destination
                    )

                    routeInfoRow(
                        icon: "tram.fill",
                        title: "Próxima estación",
                        value: nextStation
                    )

                    routeInfoRow(
                        icon: "point.topleft.down.curvedto.point.bottomright.up.fill",
                        title: "Estaciones restantes",
                        value: "\(remainingStations)"
                    )
                }
                .padding()
                .background(.white)
                .cornerRadius(28)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 10,
                    y: 4
                )
                .padding(.horizontal)
                
                if let stationTransfers = transfers[station] {

                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {

                        Text("Transbordos disponibles")
                            .font(.headline)

                        ForEach(
                            stationTransfers,
                            id: \.self
                        ) { transfer in

                            HStack(spacing: 12) {

                                Image(
                                    systemName:
                                        "arrow.triangle.swap"
                                )
                                .foregroundColor(.blue)

                                VStack(
                                    alignment: .leading,
                                    spacing: 4
                                ) {

                                    Text(transfer)
                                        .font(.headline)

                                    Text(
                                        "Conexión disponible"
                                    )
                                    .font(.caption)
                                    .foregroundColor(
                                        .secondary
                                    )
                                }

                                Spacer()
                            }
                            .padding()
                            .background(
                                Color.blue.opacity(0.08)
                            )
                            .cornerRadius(18)
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(28)
                    .shadow(
                        color: .black.opacity(0.08),
                        radius: 10,
                        y: 4
                    )
                    .padding(.horizontal)
                }

                // Configuración

                VStack(alignment: .leading, spacing: 20) {

                    Text("Configuración")
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

                    Stepper(
                        "Hora: \(selectedHour):00 hrs",
                        value: $selectedHour,
                        in: 0...23
                    )

                    VStack(alignment: .leading) {

                        Text("Nivel de tráfico")
                            .font(.subheadline)

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
                }
                .padding()
                .background(.white)
                .cornerRadius(28)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 10,
                    y: 4
                )
                .padding(.horizontal)

                // Resultado IA

                VStack(spacing: 18) {

                    Text("Predicción IA")
                        .font(.headline)

                    HStack(spacing: 8) {

                        ForEach(0..<5) { index in

                            RoundedRectangle(
                                cornerRadius: 8
                            )
                            .fill(
                                barColor(for: index)
                            )
                            .frame(
                                width: 40,
                                height: 18
                            )
                        }
                    }

                    Text(prediction)
                        .font(.system(
                            size: 34,
                            weight: .bold
                        ))
                        .foregroundColor(
                            saturationColor
                        )

                    Divider()

                    HStack {

                        VStack {

                            Text("Próxima unidad")
                                .font(.caption)

                            Text("\(arrivalTime) min")
                                .font(.title2.bold())
                        }

                        Spacer()

                        VStack {

                            Text("Estado")
                                .font(.caption)

                            Text(serviceStatus)
                                .font(.headline)
                                .multilineTextAlignment(
                                    .center
                                )
                        }
                    }
                }
                .padding()
                .background(
                    saturationColor.opacity(0.1)
                )
                .cornerRadius(30)
                .padding(.horizontal)
            }
            .padding(.bottom, 30)
        }
        .background(
            Color(.systemGroupedBackground)
        )
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {

            saveToHistory()
        }
    }

    func routeInfoRow(
        icon: String,
        title: String,
        value: String
    ) -> some View {

        HStack(spacing: 14) {

            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(line.color)

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.headline)
            }

            Spacer()
        }
    }

    func barColor(for index: Int) -> Color {

        switch prediction {

        case "Alta":
            return index < 5
            ? .red
            : .gray.opacity(0.2)

        case "Media":
            return index < 3
            ? .orange
            : .gray.opacity(0.2)

        default:
            return index < 2
            ? .green
            : .gray.opacity(0.2)
        }
    }

    private func saveToHistory() {

        HistoryService.shared.savePrediction(
            line: line.name,
            station: station,
            destination: destination,
            prediction: prediction,
            hour: selectedHour,
            day: selectedDay,
            estimatedTime: arrivalTime
        )
    }
}
