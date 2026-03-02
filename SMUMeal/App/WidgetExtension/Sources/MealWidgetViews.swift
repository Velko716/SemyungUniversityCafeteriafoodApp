import SwiftUI
import WidgetKit

// MARK: - Color Extension

extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }

    static let widgetBackground = Color(hex: 0x222f3e)
    static let widgetText = Color(hex: 0xc8d6e5)
    static let widgetAccent = Color(hex: 0x54a0ff)
}

// MARK: - Small Widget View

struct MealWidgetSmallView: View {
    let entry: MealEntry

    private var currentMenu: String {
        switch entry.currentMealLabel {
        case "조식": return entry.breakfastMenu
        case "중식": return entry.lunchMenu
        case "석식": return entry.dinnerMenu
        default: return entry.lunchMenu
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(entry.cafeteriaDisplayName)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(Color.widgetAccent)
                Spacer()
                Text(entry.currentMealLabel)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(Color.widgetText.opacity(0.7))
            }

            Text(entry.dateDisplayString)
                .font(.system(size: 9, weight: .medium))
                .foregroundStyle(Color.widgetText.opacity(0.5))

            Divider()
                .background(Color.widgetText.opacity(0.3))

            Text(currentMenu)
                .font(.system(size: 10))
                .foregroundStyle(Color.widgetText)
                .lineLimit(nil)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(10)
        .containerBackground(Color.widgetBackground, for: .widget)
    }
}

// MARK: - Medium Widget View

struct MealWidgetMediumView: View {
    let entry: MealEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .bottom) {
                Text(entry.cafeteriaDisplayName)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Color.widgetAccent)
                Spacer()
                Text(entry.dateDisplayString)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.widgetText.opacity(0.5))
            }

            Divider()
                .background(Color.widgetText.opacity(0.3))

            HStack(alignment: .top, spacing: 8) {
                mealColumn(label: "조식", menu: entry.breakfastMenu, isActive: entry.currentMealLabel == "조식")
                divider
                mealColumn(label: "중식", menu: entry.lunchMenu, isActive: entry.currentMealLabel == "중식")
                divider
                mealColumn(label: "석식", menu: entry.dinnerMenu, isActive: entry.currentMealLabel == "석식")
            }
            .frame(maxHeight: .infinity)
        }
        .padding(12)
        .containerBackground(Color.widgetBackground, for: .widget)
    }

    private func mealColumn(label: String, menu: String, isActive: Bool) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(label)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(isActive ? Color.widgetAccent : Color.widgetText.opacity(0.5))

            Text(menu)
                .font(.system(size: 9))
                .foregroundStyle(Color.widgetText)
                .lineLimit(nil)
                .minimumScaleFactor(0.8)
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var divider: some View {
        Rectangle()
            .fill(Color.widgetText.opacity(0.2))
            .frame(width: 0.5)
    }
}

// MARK: - Large Widget View

struct MealWidgetLargeView: View {
    let entry: MealEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .bottom) {
                Text(entry.cafeteriaDisplayName)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.widgetAccent)
                Spacer()
                Text(entry.dateDisplayString)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color.widgetText.opacity(0.5))
            }

            Divider()
                .background(Color.widgetText.opacity(0.3))

            mealSection(label: "조식", menu: entry.breakfastMenu, isActive: entry.currentMealLabel == "조식")

            Divider()
                .background(Color.widgetText.opacity(0.2))

            mealSection(label: "중식", menu: entry.lunchMenu, isActive: entry.currentMealLabel == "중식")

            Divider()
                .background(Color.widgetText.opacity(0.2))

            mealSection(label: "석식", menu: entry.dinnerMenu, isActive: entry.currentMealLabel == "석식")
        }
        .padding(14)
        .containerBackground(Color.widgetBackground, for: .widget)
    }

    private func mealSection(label: String, menu: String, isActive: Bool) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(isActive ? Color.widgetAccent : Color.widgetText.opacity(0.5))

            Text(menu)
                .font(.system(size: 10))
                .foregroundStyle(Color.widgetText)
                .lineLimit(nil)
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
