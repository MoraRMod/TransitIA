import SwiftUI

struct SplashView: View {

    @State private var isActive = false
    @State private var scale = 0.8
    @State private var opacity = 0.5

    var body: some View {

        if isActive {

            ContentView()

        } else {

            ZStack {

                LinearGradient(
                    colors: [.blue, .cyan],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {

                    Image(systemName: "bus.doubledecker.fill")
                        .font(.system(size: 90))
                        .foregroundColor(.white)

                    Text("TransitIA")
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(.white)

                    Text("Movilidad Inteligente")
                        .foregroundColor(.white.opacity(0.9))
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {

                    withAnimation(.easeInOut(duration: 1.2)) {

                        scale = 1
                        opacity = 1
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {

                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
