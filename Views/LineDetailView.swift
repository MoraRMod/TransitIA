import SwiftUI

struct LineDetailView: View {

    let line: TransitLine

    var transfers: [String: String] {

        [
            "Independencia Norte":
                "Conexión Línea 7",

            "Periférico Norte":
                "Conexión Línea 7",

            "Periférico Sur":
                "Conexión Línea 7",

            "Periférico Belenes":
                "Conexión Línea 7",

            "Jalisco 200 Años":
                "Conexión Línea 7 / Línea 4",

            "Las Juntas":
                "Conexión Línea 4",

            "Carretera a Chapala":
                "Conexión Línea 7",

            "Agua Azul":
                "Conexión Línea 5 / Línea 6",

            "Fray Angélico":
                "Conexión Línea 4",

            "Juárez":
                "Conexión Línea 2",

            "Plaza Universidad":
                "Conexión Línea 3",

            "San Juan de Dios":
                "Conexión Línea 6",

            "Independencia":
                "Conexión Línea 6",

            "Bicentenario":
                "Conexión Línea 3",

            "Ávila Camacho":
                "Conexión Línea 1 / Línea 3"
        ]
    }

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 20
            ) {

                // Header

                VStack(
                    alignment: .leading,
                    spacing: 8
                ) {

                    HStack {

                        Circle()
                            .fill(line.color)
                            .frame(
                                width: 22,
                                height: 22
                            )

                        Text(line.name)
                            .font(
                                .largeTitle.bold()
                            )
                    }

                    Text(line.type)
                        .foregroundColor(
                            .secondary
                        )

                    Text(
                        "\(line.stations.count) estaciones"
                    )
                    .font(.subheadline)
                    .foregroundColor(
                        .secondary
                    )
                }
                .padding(.horizontal)

                // Línea visual

                VStack(
                    spacing: 0
                ) {

                    ForEach(
                        Array(
                            line.stations.enumerated()
                        ),
                        id: \.element
                    ) { index, station in

                        NavigationLink {

                            StationDetailView(
                                line: line,
                                station: station
                            )

                        } label: {

                            HStack(
                                alignment: .top,
                                spacing: 14
                            ) {

                                // Línea del metro

                                VStack(
                                    spacing: 0
                                ) {

                                    Circle()
                                        .fill(
                                            line.color
                                        )
                                        .frame(
                                            width: 18,
                                            height: 18
                                        )

                                    if index != line.stations.count - 1 {

                                        Rectangle()
                                            .fill(
                                                line.color
                                            )
                                            .frame(
                                                width: 3,
                                                height: 60
                                            )
                                    }
                                }

                                VStack(
                                    alignment: .leading,
                                    spacing: 8
                                ) {

                                    Text(station)
                                        .font(
                                            .headline
                                        )
                                        .foregroundColor(
                                            .primary
                                        )

                                    if let transfer =
                                        transfers[
                                            station
                                        ] {

                                        HStack(
                                            spacing: 6
                                        ) {

                                            Image(
                                                systemName:
                                                "arrow.triangle.swap"
                                            )

                                            Text(
                                                transfer
                                            )
                                            .font(
                                                .caption
                                            )
                                        }
                                        .foregroundColor(
                                            .blue
                                        )
                                        .padding(
                                            .horizontal,
                                            10
                                        )
                                        .padding(
                                            .vertical,
                                            6
                                        )
                                        .background(
                                            Color.blue
                                                .opacity(
                                                    0.1
                                                )
                                        )
                                        .cornerRadius(
                                            10
                                        )
                                    }
                                }

                                Spacer()

                                Image(
                                    systemName:
                                    "chevron.right"
                                )
                                .foregroundColor(
                                    .gray
                                )
                            }
                            .padding(
                                .horizontal
                            )
                            .padding(
                                .vertical,
                                6
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(
            Color(
                .systemGroupedBackground
            )
        )
        .navigationBarTitleDisplayMode(
            .inline
        )
    }
}
