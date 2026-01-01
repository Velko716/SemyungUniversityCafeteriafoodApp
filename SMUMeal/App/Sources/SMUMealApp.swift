import SwiftUI
import FirebaseCore
import Meal
import Repository
import Network

@main
struct SMUMealApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MealCarouselView(repository: MealRepository(firestore: FirestoreManager.shared))
        }
    }
}
