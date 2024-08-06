//
//  MinimalDeskDateWidget.swift
//  MinimalDeskDateWidget
//
//  Created by Rakib Hasan on 17/7/24.
//

import WidgetKit
import SwiftUI


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        for dayOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .second, value: dayOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct MinimalDeskDateWidgetEntryView : View {
    var entry: Provider.Entry
    
    let height = 90.0

    var body: some View {
        DateWidgetView(height: height)
    }
}

struct MinimalDeskDateWidget: Widget {
    let kind: String = "MinimalDeskDateWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MinimalDeskDateWidgetEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                MinimalDeskDateWidgetEntryView(entry: entry)
                    .padding()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    MinimalDeskDateWidget()
} timeline: {
    SimpleEntry(date: .now)
}

//struct ItemView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MinimalDeskDateWidgetEntryView(entry: .init(date: .now))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//            .frame(width: 60.0, height: 60.0, alignment: .topLeading)
//    }
//}
