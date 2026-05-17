import SwiftUI

struct ContentView: View {

    let lines: [TransitLine] = [

        TransitLine(
            name: "Línea 1",
            type: "Tren Ligero",
            color: "red",
            stations: [
                "Auditorio",
                "Periférico Norte",
                "Dermatológico",
                "Ávila Camacho",
                "Juárez",
                "Mexicaltzingo",
                "Periférico Sur"
            ]
        ),

        TransitLine(
            name: "Línea 2",
            type: "Tren Ligero",
            color: "green",
            stations: [
                "Juárez",
                "San Juan de Dios",
                "Tetlán"
            ]
        ),

        TransitLine(
            name: "Línea 3",
            type: "Tren Ligero",
            color: "pink",
            stations: [
                "Arcos de Zapopan",
                "Periférico Belenes",
                "Mercado del Mar",
                "Zapopan Centro",
                "Plaza Patria",
                "Ávila Camacho",
                "Guadalajara Centro",
                "Central de Autobuses"
            ]
        ),

        TransitLine(
            name: "Línea 4",
            type: "Tren Ligero",
            color: "orange",
            stations: [
                "Tlajomulco Centro",
                "Las Juntas"
            ]
        ),

        TransitLine(
            name: "Línea 5",
            type: "Macro Aeropuerto",
            color: "cyan",
            stations: [
                "Aeropuerto",
                "Tlaquepaque Centro"
            ]
        ),

        TransitLine(
            name: "Línea 6",
            type: "Macro Calzada",
            color: "mint",
            stations: [
                "Mirador",
                "Independencia Norte",
                "San Juan de Dios"
            ]
        ),

        TransitLine(
            name: "Línea 7",
            type: "Macro Periférico",
            color: "purple",
            stations: [
                "Barranca de Huentitán",
                "Periférico Norte",
                "CUCEA",
                "Centro Sur"
            ]
        )
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

                        Text("TransitIA GDL")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)

                        Text("Sistema de transporte SITEUR Guadalajara")
                            .foregroundColor(.white.opacity(0.9))

                        NavigationLink(destination: HistoryView()) {

                            menuButton(
                                title: "Ver historial",
                                icon: "clock.arrow.circlepath"
                            )
                        }

                        NavigationLink(destination: StatsView()) {

                            menuButton(
                                title: "Ver estadísticas",
                                icon: "chart.bar.fill"
                            )
                        }

                        ForEach(lines) { line in

                            NavigationLink(
                                destination: LineDetailView(line: line)
                            ) {

                                LineCardView(line: line)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
    }

    func menuButton(
        title: String,
        icon: String
    ) -> some View {

        HStack {

            Image(systemName: icon)

            Text(title)
                .bold()
        }
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white.opacity(0.2))
        .cornerRadius(15)
    }
}

#Preview {
    ContentView()
}
