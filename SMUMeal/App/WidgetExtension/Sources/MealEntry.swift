import WidgetKit

struct MealEntry: TimelineEntry {
    let date: Date
    let cafeteriaDisplayName: String
    let breakfastMenu: String
    let lunchMenu: String
    let dinnerMenu: String
    let currentMealLabel: String

    var dateDisplayString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd (E)"
        return formatter.string(from: date)
    }

    static func placeholder(cafeteriaName: String) -> MealEntry {
        MealEntry(
            date: .now,
            cafeteriaDisplayName: cafeteriaName,
            breakfastMenu: "조식 메뉴를 불러오는 중...",
            lunchMenu: "중식 메뉴를 불러오는 중...",
            dinnerMenu: "석식 메뉴를 불러오는 중...",
            currentMealLabel: "중식"
        )
    }
}
