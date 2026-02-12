import SwiftUI
import Meal
import Repository
import Network
import DesignSystem

@main
struct SMUMealApp: App {

    var body: some Scene {
        WindowGroup {
            MealCarouselView(repository: MealRepository())
        }
    }
}
