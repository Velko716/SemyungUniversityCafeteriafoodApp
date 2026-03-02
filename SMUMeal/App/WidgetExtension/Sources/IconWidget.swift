import SwiftUI
import WidgetKit

// MARK: - Icon Widget

struct IconWidget: Widget {
    let kind: String = "iconWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: IconTimelineProvider()) { entry in
            IconWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("학식 알리미")
        .description("잠금화면에 앱 아이콘을 표시합니다.")
        .supportedFamilies([.accessoryCircular])
    }
}

// MARK: - Timeline Provider

struct IconTimelineEntry: TimelineEntry {
    let date: Date
}

struct IconTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> IconTimelineEntry {
        IconTimelineEntry(date: .now)
    }

    func getSnapshot(in context: Context, completion: @escaping (IconTimelineEntry) -> Void) {
        completion(IconTimelineEntry(date: .now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<IconTimelineEntry>) -> Void) {
        let entry = IconTimelineEntry(date: .now)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

// MARK: - Widget View

struct IconWidgetEntryView: View {
    @Environment(\.widgetRenderingMode) var renderingMode
    let entry: IconTimelineEntry

    var body: some View {
        ZStack {
            AccessoryWidgetBackground()
            Image("WidgetIcon")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
        }
        .containerBackground(.clear, for: .widget)
    }
}
