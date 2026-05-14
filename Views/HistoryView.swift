import SwiftUI

struct HistoryView: View {

    @State private var history: [HistoryItem] = []

    var body: some View {

        NavigationView {

            ZStack {

                LinearGradient(
                    colors: [.purple.opacity(0.7), .blue.opacity(0.5)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                if history.isEmpty {

                    VStack(spacing: 20) {

                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 70))
                            .foregroundColor(.white)

                        Text("No hay historial")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                } else {

                    ScrollView {

                        VStack(spacing: 15) {

                            ForEach(history) { item in

                                VStack(alignment: .leading, spacing: 10) {

                                    Text(item.routeName)
                                        .font(.headline)

                                    Text("Predicción: \(item.prediction)")

                                    Text("Hora: \(item.hour):00 hrs")

                                    Text("Día: \(item.day)")
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.white)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Historial")
            .onAppear {

                history = HistoryService.shared.fetchHistory()
            }
        }
    }
}

#Preview {
    HistoryView()
}
