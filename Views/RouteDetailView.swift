import SwiftUI

struct RouteDetailView: View {

    let route: BusRoute

    var body: some View {

        VStack(spacing: 20) {

            Text(route.name)
                .font(.largeTitle)
                .bold()

            Text("Tiempo estimado")
                .font(.title2)

            Text(route.waitTime)
                .font(.system(size: 40))
                .bold()

            Text("Saturación")

            Text(route.saturation)
                .font(.title)
                .foregroundColor(.red)

            Spacer()
        }
        .padding()
    }
}
