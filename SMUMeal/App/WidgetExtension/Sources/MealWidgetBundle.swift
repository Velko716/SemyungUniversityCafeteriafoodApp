import SwiftUI
import WidgetKit

@main
struct MealWidgetBundle: WidgetBundle {
    var body: some Widget {
        StudentCafeteriaWidget()
        SelfServiceCafeteriaWidget()
        YejiDormitoryWidget()
        IconWidget()
    }
}
