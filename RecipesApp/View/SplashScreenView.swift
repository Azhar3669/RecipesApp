
import SwiftUI

struct SplashScreenView: View {
    @StateObject private var viewModel = SplashViewModel()

    var body: some View {
        if viewModel.isActive {
            ContentView()
        } else {
            VStack(spacing: 20) {
                Image(systemName: "fork.knife")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)

                Text("Recipe App")
                    .font(.largeTitle)
                    .bold()

                Text("Delicious recipes for everyone")
                    .foregroundColor(.gray)
            }
            .onAppear {
                viewModel.start()
            }
        }
    }
}
