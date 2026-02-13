import SwiftUI
import Meal
import Repository
import Network

@main
struct SMUMealApp: App {

    var body: some Scene {
        WindowGroup {
            MealCarouselView(repository: MealRepository())
        }
    }
}
