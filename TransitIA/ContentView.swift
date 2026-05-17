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
