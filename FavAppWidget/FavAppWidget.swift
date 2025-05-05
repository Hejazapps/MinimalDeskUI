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
    
    @State private var widgetConfig: FavAppWidgetConfig
    
    let cardIndex: Int
    
    init(entry: Provider.Entry, cardIndex: Int = 0) {
        self.entry = entry
        self.widgetConfig = FavAppWidgetConfig.defaultConfig
        self.cardIndex = cardIndex
    }
    
    var body: some View {
        ZStack {
            Color(hex: widgetConfig.backgroundColor)
                .ignoresSafeArea()
            
            if favApps.isEmpty {
                Text("Add Favorite apps to be shown here.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: widgetConfig.fontColor))
                    .ignoresSafeArea()
            } else {
                HStack {
                    if getAlignment(widgetConfig.alignment) == .trailing {
                        Spacer()
                    }
                    
                    VStack(alignment: getAlignment(widgetConfig.alignment), spacing: widgetConfig.spacing) {
                        
                        ForEach(favApps.prefix(widgetConfig.maxNumberOfApps), id: \.self) { app in
                            
                            Button(intent: OpenAppIntent(urlStr: app["link"] ?? "Empty Link")) {
                                Text(app["name"] ?? "Loading...")
                                    .foregroundColor(Color(hex: widgetConfig.fontColor))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .font(Font.custom(widgetConfig.fontType, size: CGFloat(widgetConfig.fontSize)))
                        }
                    }
                    .padding(.horizontal, 25)
                    .onAppear {
                        let userDefault = UserDefaults(suiteName: "group.minimaldesk") ?? UserDefaults()
                        favApps = (userDefault.value(forKey: "favorite-apps\(cardIndex)") as? [[String: String]] ?? [])
                            .sorted { Int($0["rank"] ?? "") ?? 0 < Int($1["rank"] ?? "") ?? 0 }
                        
                        log(favApps)
                        
                        let config = userDefault.value(forKey: "favorite-apps-config") as? Data ?? Data()
                        if let widgetConfig = try? JSONDecoder().decode(FavAppWidgetConfig.self, from: config) {
                            FavAppWidgetConfig.defaultConfig = widgetConfig
                            self.widgetConfig = widgetConfig
                        }
                    }
                    
                    if getAlignment(widgetConfig.alignment) == .leading {
                        Spacer()
                    }
                }
            }
        }
    }
    
    private func getAlignment(_ alignmentString: String) -> HorizontalAlignment {
        switch alignmentString {
        case "center": .center
        case "right": .trailing
        default: .leading
        }
    }
}

struct FavAppWidget: Widget {
    let kind: String
    let cardIndex: Int
    
    init() {
        cardIndex = 0
        kind = "FavAppWidget0"
    }
    
    init(cardIndex: Int) {
        self.cardIndex = cardIndex
        kind = "FavAppWidget\(cardIndex)"
    }
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                FavAppWidgetEntryView(entry: entry, cardIndex: cardIndex)
                    .containerBackground(for: .widget, alignment: .center, content: { EmptyView() })
            } else {
                FavAppWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .contentMarginsDisabled()
        .configurationDisplayName("FavoriteApps Widget")
        .description("Open favorite apps quickly")
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
