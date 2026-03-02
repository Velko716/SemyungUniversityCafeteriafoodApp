import SwiftUI
import WidgetKit

// MARK: - Student Cafeteria Widget

struct StudentCafeteriaWidget: Widget {
    let kind: String = "studentCafeteria"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MealTimelineProvider(
            cafeteriaType: "student_cafeteria",
            cafeteriaDisplayName: "학생회관 학생식당"
        )) { entry in
            MealWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("학생식당")
        .description("학생회관 학생식당 메뉴를 확인합니다.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Self-Service Cafeteria Widget

struct SelfServiceCafeteriaWidget: Widget {
    let kind: String = "selfServiceCafeteria"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MealTimelineProvider(
            cafeteriaType: "self_service_cafeteria",
            cafeteriaDisplayName: "학생회관 자율식당"
        )) { entry in
            MealWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("자율식당")
        .description("학생회관 자율식당 메뉴를 확인합니다.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Yeji Dormitory Widget

struct YejiDormitoryWidget: Widget {
    let kind: String = "yejiDormitoryCafeteria"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MealTimelineProvider(
            cafeteriaType: "yeji_cafeteria",
            cafeteriaDisplayName: "예지학사식당"
        )) { entry in
            MealWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("예지학사식당")
        .description("예지학사식당 메뉴를 확인합니다.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Entry View (dispatches by widget family)

struct MealWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    let entry: MealEntry

    var body: some View {
        switch family {
        case .systemSmall:
            MealWidgetSmallView(entry: entry)
        case .systemMedium:
            MealWidgetMediumView(entry: entry)
        case .systemLarge:
            MealWidgetLargeView(entry: entry)
        default:
            MealWidgetSmallView(entry: entry)
        }
    }
}
