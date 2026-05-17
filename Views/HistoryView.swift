import SwiftUI

struct HistoryView: View {

    @State private var history:
    [PredictionEntity] = []

    var body: some View {

        NavigationView {

            ZStack {

                LinearGradient(
                    colors: [
                        .purple.opacity(0.7),
                        .blue.opacity(0.5)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                if history.isEmpty {

                    VStack(spacing: 20) {

                        Image(
                            systemName:
                            "clock.arrow.circlepath"
                        )
                        .font(
                            .system(size: 70)
                        )
                        .foregroundColor(
                            .white
                        )

                        Text(
                            "No hay historial"
                        )
                        .font(.title2)
                        .foregroundColor(
                            .white
                        )
                    }

                } else {

                    ScrollView {

                        VStack(
                            spacing: 15
                        ) {

                            ForEach(
                                history,
                                id: \.id
                            ) { item in

                                VStack(
                                    alignment:
                                        .leading,
                                    spacing: 10
                                ) {

                                    Text(
                                        item.linea
                                        ?? "Sin línea"
                                    )
                                    .font(
                                        .headline
                                    )

                                    Text(
                                        "Estación: \(item.estacion ?? "")"
                                    )

                                    Text(
                                        "Destino: \(item.direccion ?? "")"
                                    )

                                    Text(
                                        "Predicción IA: \(item.prediccion ?? "")"
                                    )

                                    Text(
                                        "Hora: \(item.horaConsulta):00 hrs"
                                    )

                                    Text(
                                        "Día: \(item.dia ?? "")"
                                    )

                                    Text(
                                        "Tiempo estimado: \(item.tiempoEstimado) min"
                                    )
                                }
                                .padding()
                                .frame(
                                    maxWidth:
                                        .infinity,
                                    alignment:
                                        .leading
                                )
                                .background(
                                    .white
                                )
                                .cornerRadius(
                                    20
                                )
                                .shadow(
                                    radius: 5
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(
                "Historial"
            )
            .toolbar {

                Button(
                    "Borrar"
                ) {

                    HistoryService
                        .shared
                        .clearHistory()

                    history = []
                }
            }
            .onAppear {

                history =
                HistoryService
                    .shared
                    .fetchHistory()
            }
        }
    }
}
