import SwiftUI
import FirebaseCore
import Meal
import Repository
import Network
import DesignSystem

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
