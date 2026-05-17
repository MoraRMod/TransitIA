import SwiftUI

struct StatsView: View {

    let stats = [
        ("Ruta más saturada", "Ruta 380"),
        ("Hora pico", "18:00 hrs"),
        ("Demanda alta", "Lunes")
    ]

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [.indigo.opacity(0.7), .purple.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {

                VStack(spacing: 20) {

                    Text("Estadísticas")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    ForEach(stats, id: \.0) { item in

                        VStack(spacing: 10) {

                            Text(item.0)
                                .font(.headline)

                            Text(item.1)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.blue)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    StatsView()
}
