import SwiftUI

struct StationDetailView: View {

    let line: TransitLine
    let station: String

    @State private var selectedHour = 8
    @State private var selectedTraffic = "Alta"
    @State private var selectedDay = "Lunes"

    let trafficOptions = ["Alta", "Media", "Baja"]

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
            return 6

        case "Media":
            return 4

        default:
            return 2
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

                        Stepper(
                            "Hora: \(selectedHour):00",
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

                        VStack {

                            Text("Tiempo estimado de llegada")
                                .font(.headline)

                            Text("\(arrivalTime) min")
                                .font(.system(size: 40))
                                .bold()
                                .foregroundColor(.blue)
                        }

                        Divider()

                        VStack {

                            Text("Predicción IA")
                                .font(.headline)

                            Text(prediction)
                                .font(.title)
                                .bold()
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
