//
//  FavAppWidget.swift
//  FavAppWidget
//
//  Created by Rakib Hasan on 4/8/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for _ in 0 ..< 1 {
            let entryDate = Calendar.current.date(byAdding: .second, value: 0, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct FavAppWidgetEntryView : View {
    var entry: Provider.Entry
    
    @State private var favApps = [["name": "Testapp", "link": "Testlink"]]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                ForEach(favApps, id: \.self) { app in
                    Button(intent: OpenAppIntent(urlStr: app["link"] ?? "Empty Link")) {
                        Text(app["name"] ?? "Loading...")
                    }
                    .padding(.vertical, 3)
                    .buttonStyle(PlainButtonStyle())
                    .font(.title)
                    .bold()
                }
                .padding(.leading, 25)
                .onAppear {
                    let userDefault = UserDefaults(suiteName: "group.minimaldesk") ?? UserDefaults()
                    favApps = userDefault.value(forKey: "favorite-apps") as? [[String: String]] ?? []
                    log(favApps)
                }
                .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(.vertical)
    }
}

struct FavAppWidget: Widget {
    let kind: String = "FavAppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                FavAppWidgetEntryView(entry: entry)
                    .containerBackground(.black, for: .widget)
            } else {
                FavAppWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge])
    }
}
//
//#Preview(as: .systemLarge) {
//    FavAppWidget()
//} timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
//}
