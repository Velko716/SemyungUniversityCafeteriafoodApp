import SwiftUI
import FirebaseCore
import Home

@main
struct SMUMealApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            TestFeature()
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}
