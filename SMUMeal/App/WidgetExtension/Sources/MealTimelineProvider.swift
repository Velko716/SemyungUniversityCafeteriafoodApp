import WidgetKit
import Network
import Domain
import Utility

struct MealTimelineProvider: TimelineProvider {
    let cafeteriaType: String
    let cafeteriaDisplayName: String

    func placeholder(in context: Context) -> MealEntry {
        .placeholder(cafeteriaName: cafeteriaDisplayName)
    }

    func getSnapshot(in context: Context, completion: @escaping (MealEntry) -> Void) {
        if context.isPreview {
            completion(.placeholder(cafeteriaName: cafeteriaDisplayName))
            return
        }
        fetchEntry(for: .now) { entry in
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MealEntry>) -> Void) {
        fetchEntry(for: .now) { entry in
            let calendar = Calendar.current
            let now = Date.now

            let todayComponents = calendar.dateComponents([.year, .month, .day], from: now)

            // 09:30 today
            var lunchComponents = todayComponents
            lunchComponents.hour = 9
            lunchComponents.minute = 30
            let lunchDate = calendar.date(from: lunchComponents)!

            // 15:00 today
            var dinnerComponents = todayComponents
            dinnerComponents.hour = 15
            dinnerComponents.minute = 0
            let dinnerDate = calendar.date(from: dinnerComponents)!

            // 22:00 today (for next day's breakfast)
            var breakfastComponents = todayComponents
            breakfastComponents.hour = 22
            breakfastComponents.minute = 0
            let breakfastDate = calendar.date(from: breakfastComponents)!

            // Determine next refresh date
            let nextRefresh: Date
            if now < lunchDate {
                nextRefresh = lunchDate
            } else if now < dinnerDate {
                nextRefresh = dinnerDate
            } else if now < breakfastDate {
                nextRefresh = breakfastDate
            } else {
                // After 22:00 — next refresh at tomorrow 09:30
                nextRefresh = calendar.date(byAdding: .day, value: 1, to: lunchDate)!
            }

            // Build entries for each meal transition
            let breakfastEntry = MealEntry(
                date: now < lunchDate ? now : breakfastDate,
                cafeteriaDisplayName: cafeteriaDisplayName,
                breakfastMenu: entry.breakfastMenu,
                lunchMenu: entry.lunchMenu,
                dinnerMenu: entry.dinnerMenu,
                currentMealLabel: "조식"
            )

            let lunchEntry = MealEntry(
                date: lunchDate,
                cafeteriaDisplayName: cafeteriaDisplayName,
                breakfastMenu: entry.breakfastMenu,
                lunchMenu: entry.lunchMenu,
                dinnerMenu: entry.dinnerMenu,
                currentMealLabel: "중식"
            )

            let dinnerEntry = MealEntry(
                date: dinnerDate,
                cafeteriaDisplayName: cafeteriaDisplayName,
                breakfastMenu: entry.breakfastMenu,
                lunchMenu: entry.lunchMenu,
                dinnerMenu: entry.dinnerMenu,
                currentMealLabel: "석식"
            )

            // Only include future entries + current
            var entries: [MealEntry] = []
            if now < lunchDate {
                entries.append(breakfastEntry)
                entries.append(lunchEntry)
                entries.append(dinnerEntry)
            } else if now < dinnerDate {
                entries.append(lunchEntry)
                entries.append(dinnerEntry)
            } else if now < breakfastDate {
                entries.append(dinnerEntry)
            } else {
                // After 22:00, show breakfast for next day
                entries.append(breakfastEntry)
            }

            let timeline = Timeline(entries: entries, policy: .after(nextRefresh))
            completion(timeline)
        }
    }

    private func fetchEntry(for date: Date, completion: @escaping (MealEntry) -> Void) {
        let dateString = date.fullDateString
        let request = FetchMenuRequest(cafeteriaType: cafeteriaType, date: dateString)

        let baseURL = Bundle.main.apiBaseURL
        let apiKey = Bundle.main.apiKey
        print("[Widget] baseURL: \(baseURL)")
        print("[Widget] apiKey isEmpty: \(apiKey.isEmpty)")
        print("[Widget] request path: \(request.path)")

        let client = APIClient(baseURL: baseURL, apiKey: apiKey)

        Task {
            do {
                let menu = try await client.send(request)
                let mealLabel = Self.currentMealLabel(for: date)
                let entry = MealEntry(
                    date: date,
                    cafeteriaDisplayName: cafeteriaDisplayName,
                    breakfastMenu: menu.breakfastMenu.replacingLiteralNewlines(),
                    lunchMenu: menu.lunchMenu.replacingLiteralNewlines(),
                    dinnerMenu: menu.dinnerMenu.replacingLiteralNewlines(),
                    currentMealLabel: mealLabel
                )
                completion(entry)
            } catch {
                print("[Widget] Fetch error: \(error)")
                let entry = MealEntry(
                    date: date,
                    cafeteriaDisplayName: cafeteriaDisplayName,
                    breakfastMenu: "아직 식단이 등록되지 않았습니다.",
                    lunchMenu: "아직 식단이 등록되지 않았습니다.",
                    dinnerMenu: "아직 식단이 등록되지 않았습니다.",
                    currentMealLabel: Self.currentMealLabel(for: date)
                )
                completion(entry)
            }
        }
    }

    static func currentMealLabel(for date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let time = hour * 60 + minute

        if time < 9 * 60 + 30 {
            return "조식"
        } else if time < 15 * 60 {
            return "중식"
        } else {
            return "석식"
        }
    }
}
