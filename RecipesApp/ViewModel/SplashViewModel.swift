
import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var isActive = false

    func start() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.isActive = true
        }
    }
}
