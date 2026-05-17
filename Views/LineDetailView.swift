import SwiftUI

struct LineDetailView: View {

    let line: TransitLine

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

                    Text(line.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Text(line.type)
                        .foregroundColor(.white.opacity(0.9))

                    Text("Selecciona tu estación")
                        .foregroundColor(.white)

                    ForEach(line.stations, id: \.self) { station in

                        NavigationLink {

                            StationDetailView(
                                line: line,
                                station: station
                            )

                        } label: {

                            HStack {

                                Circle()
                                    .fill(line.color)
                                    .frame(width: 14)

                                Text(station)

                                Spacer()

                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.black)
                            .padding()
                            .background(.white)
                            .cornerRadius(20)
                        }
                    }
                }
                .padding()
            }
        }
    }
}
