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

        ZStack {

            LinearGradient(
                colors: [
                    line.color.opacity(0.9),
                    line.color.opacity(0.5)
                ],
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

                        Divider()

                        infoCard(
                            title: "Destino",
                            value: destination
                        )

                        infoCard(
                            title: "Próxima estación",
                            value: nextStation
                        )

                        infoCard(
                            title: "Estaciones restantes",
                            value: "\(remainingStations)"
                        )

                        infoCard(
                            title: "Próxima unidad",
                            value: "\(arrivalTime) min"
                        )

                        infoCard(
                            title: "Estado del servicio",
                            value: serviceStatus
                        )

                        VStack(spacing: 15) {

                            Text("Nivel de saturación")
                                .font(.headline)

                            HStack(spacing: 8) {

                                ForEach(0..<5) { index in

                                    RoundedRectangle(
                                        cornerRadius: 8
                                    )
                                    .fill(barColor(for: index))
                                    .frame(height: 18)
                                }
                            }

                            Text(prediction)
                                .font(.title2)
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

    func infoCard(
        title: String,
        value: String
    ) -> some View {

        VStack(spacing: 8) {

            Text(title)
                .font(.headline)

            Text(value)
                .font(.title3)
                .bold()
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
}
