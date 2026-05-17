import SwiftUI

struct HistoryView: View {

    @State private var history:
    [PredictionEntity] = []

    var body: some View {

        NavigationView {

            Group {

                if history.isEmpty {

                    VStack(spacing: 24) {

                        Spacer()

                        Image(
                            systemName:
                            "clock.arrow.circlepath"
                        )
                        .font(
                            .system(size: 70)
                        )
                        .foregroundColor(.gray)

                        Text("Sin historial")
                            .font(.title.bold())

                        Text(
                            "Tus consultas de movilidad aparecerán aquí."
                        )
                        .foregroundColor(
                            .secondary
                        )
                        .multilineTextAlignment(
                            .center
                        )
                        .padding(.horizontal)

                        Spacer()
                    }

                } else {

                    ScrollView {

                        VStack(
                            spacing: 18
                        ) {

                            ForEach(
                                history,
                                id: \.id
                            ) { item in

                                VStack(
                                    alignment:
                                        .leading,
                                    spacing: 16
                                ) {

                                    // Header

                                    HStack {

                                        Circle()
                                            .fill(
                                                colorForLine(
                                                    item.linea ?? ""
                                                )
                                            )
                                            .frame(
                                                width: 14,
                                                height: 14
                                            )

                                        Text(
                                            item.linea
                                            ?? "Sin línea"
                                        )
                                        .font(
                                            .headline
                                        )

                                        Spacer()

                                        predictionBadge(
                                            item.prediccion
                                            ?? ""
                                        )
                                    }

                                    // Trayecto

                                    VStack(
                                        alignment:
                                            .leading,
                                        spacing: 8
                                    ) {

                                        Label(
                                            item.estacion ?? "",
                                            systemImage:
                                                "mappin.circle.fill"
                                        )

                                        Label(
                                            item.direccion ?? "",
                                            systemImage:
                                                "flag.circle.fill"
                                        )
                                    }
                                    .foregroundColor(
                                        .secondary
                                    )

                                    Divider()

                                    // Datos

                                    HStack {

                                        VStack(
                                            alignment:
                                                .leading,
                                            spacing: 4
                                        ) {

                                            Text("Hora")
                                                .font(
                                                    .caption
                                                )
                                                .foregroundColor(
                                                    .secondary
                                                )

                                            Text(
                                                "\(item.horaConsulta):00"
                                            )
                                            .bold()
                                        }

                                        Spacer()

                                        VStack(
                                            alignment:
                                                .leading,
                                            spacing: 4
                                        ) {

                                            Text("Día")
                                                .font(
                                                    .caption
                                                )
                                                .foregroundColor(
                                                    .secondary
                                                )

                                            Text(
                                                item.dia ?? ""
                                            )
                                            .bold()
                                        }

                                        Spacer()

                                        VStack(
                                            alignment:
                                                .leading,
                                            spacing: 4
                                        ) {

                                            Text(
                                                "Tiempo"
                                            )
                                            .font(
                                                .caption
                                            )
                                            .foregroundColor(
                                                .secondary
                                            )

                                            Text(
                                                "\(item.tiempoEstimado) min"
                                            )
                                            .bold()
                                        }
                                    }
                                }
                                .padding()
                                .background(
                                    .white
                                )
                                .cornerRadius(
                                    28
                                )
                                .shadow(
                                    color:
                                        .black.opacity(
                                            0.08
                                        ),
                                    radius: 10,
                                    y: 4
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(
                Color(
                    .systemGroupedBackground
                )
            )
            .navigationTitle(
                "Historial"
            )
            .toolbar {

                ToolbarItem(
                    placement:
                        .topBarTrailing
                ) {

                    Button(
                        role:
                            .destructive
                    ) {

                        HistoryService
                            .shared
                            .clearHistory()

                        history = []

                    } label: {

                        Image(
                            systemName:
                            "trash"
                        )
                    }
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

    func predictionBadge(
        _ prediction: String
    ) -> some View {

        Text(prediction.uppercased())
            .font(
                .caption.bold()
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                badgeColor(
                    prediction
                )
                .opacity(0.15)
            )
            .foregroundColor(
                badgeColor(
                    prediction
                )
            )
            .cornerRadius(14)
    }

    func badgeColor(
        _ prediction: String
    ) -> Color {

        switch prediction {

        case "Alta":
            return .red

        case "Media":
            return .orange

        default:
            return .green
        }
    }

    func colorForLine(
        _ line: String
    ) -> Color {

        switch line {

        case "Línea 1":
            return .red

        case "Línea 2":
            return .green

        case "Línea 3":
            return .pink

        case "Línea 4":
            return .orange

        case "Línea 5":
            return .cyan

        case "Línea 6":
            return .mint

        case "Línea 7":
            return .purple

        default:
            return .gray
        }
    }
}
