import SwiftUI

struct LineCardView: View {

    let line: TransitLine

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            HStack {

                Image(systemName: "tram.fill")
                    .font(.title2)
                    .foregroundColor(.blue)

                VStack(alignment: .leading) {

                    Text(line.name)
                        .font(.headline)

                    Text(line.type)
                        .foregroundColor(.gray)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }

            Text("\(line.stations.count) estaciones")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

#Preview {

    LineCardView(
        line: TransitLine(
            name: "Línea 1",
            type: "Tren Ligero",
            color: "red",
            stations: []
        )
    )
}
