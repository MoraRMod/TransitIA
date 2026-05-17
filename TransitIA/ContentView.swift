import SwiftUI

struct ContentView: View {

    let lines: [TransitLine] = [

        TransitLine(
            name: "Línea 1",
            type: "Tren Ligero",
            color: .red,
            stations: [
                "Auditorio",
                "Periférico Norte",
                "Dermatológico",
                "Atemajac",
                "División del Norte",
                "Ávila Camacho",
                "Mezquitán",
                "Refugio",
                "Juárez",
                "Mexicaltzingo",
                "Washington",
                "Santa Filomena",
                "Unidad Deportiva",
                "Urdaneta",
                "18 de Marzo",
                "Isla Raza",
                "Patria",
                "España",
                "Santuario Mártires de Cristo Rey",
                "Periférico Sur"
            ]
        ),

        TransitLine(
            name: "Línea 2",
            type: "Tren Ligero",
            color: .green,
            stations: [
                "Juárez",
                "Plaza Universidad",
                "San Juan de Dios",
                "Belisario Domínguez",
                "Oblatos",
                "Cristóbal de Oñate",
                "San Andrés",
                "San Jacinto",
                "La Aurora",
                "Tetlán"
            ]
        ),

        TransitLine(
            name: "Línea 3",
            type: "Tren Ligero",
            color: .pink,
            stations: [
                "Arcos de Zapopan",
                "Periférico Belenes",
                "Mercado del Mar",
                "Zapopan Centro",
                "Plaza Patria",
                "Circunvalación Country",
                "Ávila Camacho",
                "La Normal (CETRAM)",
                "Santuario",
                "Guadalajara Centro",
                "Independencia",
                "Plaza de la Bandera",
                "CUCEI",
                "Revolución",
                "Río Nilo",
                "Tlaquepaque Centro",
                "Lázaro Cárdenas",
                "Central de Autobuses"
            ]
        ),

        TransitLine(
            name: "Línea 4",
            type: "Tren Ligero",
            color: .orange,
            stations: [
                "Tlajomulco Centro",
                "CUTLAJO",
                "Lomas del Sur",
                "El Cuervo",
                "Concepción del Valle",
                "Real del Valle",
                "Jalisco 200 Años",
                "Las Juntas"
            ]
        ),

        TransitLine(
            name: "Línea 5",
            type: "Macro Aeropuerto",
            color: .cyan,
            stations: [
                "Aeropuerto",
                "Carretera a Chapala",
                "Agua Azul",
                "El Fresno"
            ]
        ),

        TransitLine(
            name: "Línea 6",
            type: "Macro Calzada",
            color: .mint,
            stations: [
                "Mirador",
                "Huentitán",
                "Zoológico",
                "Independencia Norte",
                "San Patricio",
                "Igualdad",
                "Monumental",
                "Monte Olivete",
                "Circunvalación",
                "Ciencias de la Salud",
                "Juan Álvarez",
                "Alameda",
                "San Juan de Dios",
                "Bicentenario",
                "La Paz",
                "Niños Héroes",
                "Agua Azul",
                "Ciprés",
                "Héroes de Necozari",
                "Lázaro Cárdenas",
                "El Dean",
                "Zona Industrial",
                "López de Legazpi",
                "Clemente Orozco",
                "Artes Plásticas",
                "Esculturas",
                "Fray Angélico"
            ]
        ),

        TransitLine(
            name: "Línea 7",
            type: "Macro Periférico",
            color: .purple,
            stations: [
                "Los Conejos",
                "Colonia Jalisco",
                "Comisaría de Guadalajara",
                "Barranca de Huentitán",
                "Zoológico Guadalajara",
                "Independencia Norte",
                "Lomas del Paraíso",
                "Rancho Nuevo",
                "La Experiencia",
                "El Batán",
                "Periférico Norte",
                "La Cantera",
                "Tabachines",
                "Constitución",
                "Centro Cultural Universitario",
                "San Isidro",
                "Periférico Belenes",
                "La Tizanía",
                "Santa Margarita",
                "Acueducto",
                "5 de Mayo",
                "San Juan de Ocotán",
                "Vallarta",
                "Estadio Chivas",
                "Ciudad Judicial",
                "Ciudad Granja",
                "Parque Metropolitano",
                "Chapalita Inn",
                "El Colli",
                "Felipe Ruvalcaba",
                "Miramar",
                "Mariano Otero",
                "El Briseño",
                "Agrícola",
                "López Mateos",
                "ITESO",
                "Terminal Sur de Autobuses",
                "Periférico Sur",
                "San Sebastianito",
                "8 de Julio",
                "Toluquilla",
                "Adolf Horn",
                "Jalisco 200 Años",
                "Artesanos",
                "Las Pintas",
                "Carretera a Chapala"
            ]
        )
    ]

    var body: some View {

        NavigationView {

            ScrollView {

                VStack(alignment: .leading, spacing: 24) {

                    VStack(alignment: .leading, spacing: 8) {

                        Text("TransitIA GDL")
                            .font(.system(size: 34, weight: .bold))

                        Text("Movilidad inteligente para Guadalajara")
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: HistoryView()) {

                        HStack {

                            Image(systemName: "clock.arrow.circlepath")

                            Text("Ver historial")
                                .bold()

                            Spacer()

                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.primary)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(18)
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 15) {

                        Text("Líneas disponibles")
                            .font(.title2.bold())
                            .padding(.horizontal)

                        ForEach(lines) { line in

                            NavigationLink(
                                destination:
                                    LineDetailView(
                                        line: line
                                    )
                            ) {

                                HStack(spacing: 16) {

                                    Circle()
                                        .fill(line.color)
                                        .frame(
                                            width: 18,
                                            height: 18
                                        )

                                    VStack(
                                        alignment: .leading,
                                        spacing: 4
                                    ) {

                                        Text(line.name)
                                            .font(.headline)

                                        Text(line.type)
                                            .foregroundColor(
                                                .secondary
                                            )

                                        Text(
                                            "\(line.stations.count) estaciones"
                                        )
                                        .font(.caption)
                                        .foregroundColor(
                                            .secondary
                                        )
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
                                .padding()
                                .background(.white)
                                .cornerRadius(22)
                                .shadow(
                                    color: .black.opacity(0.08),
                                    radius: 8,
                                    y: 4
                                )
                                .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.vertical)
            }
            .background(
                Color(.systemGroupedBackground)
            )
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
