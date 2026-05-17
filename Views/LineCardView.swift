import SwiftUI

struct LineCardView: View {

    let line: TransitLine

    var body: some View {

        HStack(spacing: 15) {

            RoundedRectangle(cornerRadius: 10)
                .fill(line.color)
                .frame(width: 12)

            VStack(alignment: .leading, spacing: 8) {

                Text(line.name)
                    .font(.headline)

                Text(line.type)
                    .foregroundColor(.secondary)

                Text("\(line.stations.count) estaciones")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "tram.fill")
                .font(.title2)
                .foregroundColor(line.color)
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}
