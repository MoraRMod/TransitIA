import SwiftUI

struct RouteCardView: View {

    let route: BusRoute

    var saturationColor: Color {

        switch route.saturation {
        case "Alta":
            return .red

        case "Media":
            return .orange

        default:
            return .green
        }
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 15) {

            HStack {

                Image(systemName: "bus.fill")
                    .font(.title)
                    .foregroundColor(.blue)

                Text(route.name)
                    .font(.title3)
                    .bold()

                Spacer()
            }

            HStack {

                Label(route.waitTime, systemImage: "clock.fill")
                    .foregroundColor(.gray)

                Spacer()

                Text(route.saturation)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(saturationColor)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.15), radius: 8)
    }
}
