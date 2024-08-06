//
//  DateWidgetViews.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 17/7/24.
//

import Foundation
import SwiftUI

struct DateWidgetView: View {
    let height: CGFloat
    
    private var theme: String {
        let userdefault = UserDefaults(suiteName: "group.minimaldesk")
        let viewName = userdefault?.value(forKey: "current-widget-theme") as? String ?? "Nil"
        
        print("[DateWidget] [TimelineProvider] viewName = \(viewName)")

        return viewName
    }
    
    var body: some View {
        switch theme {
        case "DateTimeViewType1": DateTimeViewType1(height: height)
        case "DateTimeViewType2": DateTimeViewType2()
        case "DateTimeViewType3": DateTimeViewType3()
        default:                  DateTimeViewType2()
        }
    }
}

struct DateTimeViewType1: View {
    var date: Date { .now }
    let height: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Label(
                    title: { Text("") },
                    icon: {
                        Image(systemName: "\(date.formatted(.dateTime.day())).square")
                            .resizable()
                            .frame(width: height, height: height)
                            .foregroundColor(.white)
                    }
                )

                VStack(alignment: .leading) {
                    Text(date.formatted(.dateTime.month(.wide)))
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Spacer()
                    
                    Text(date.formatted(.dateTime.weekday(.wide)))
                        .foregroundColor(.gray)
                        .font(.title2)
                }
                .frame(height: height)
            }
        }
    }
}

struct DateTimeViewType2: View {
    var date: Date { .now }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(date.formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated)).minute()))")
                .font(.largeTitle)
                .bold()
            
            Text(date.formatted(.dateTime.month(.wide).day().year()))
                .font(.title2)
        }
        .foregroundColor(.white)
    }
}

struct DateTimeViewType3: View {
    var date: Date { .now }
    
    private var day: String { date.formatted(.dateTime.day(.twoDigits)) }
    private var month: String { date.formatted(.dateTime.month(.wide)) }
    private var year: String { date.formatted(.dateTime.year()) }
    
    var body: some View {
        HStack(alignment: .center, spacing: 15.0) {
            Text(day)
                .font(.title2)
                .padding(10)
                .background(.white)
                .clipShape(Circle())
            
            Text(month)
                .font(.title2)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(.white)
                .clipShape(Capsule())
            
            Text(year)
                .font(.title2)
                .padding(.vertical, 5)
                .padding(.horizontal)
                .overlay {
                    Capsule()
                        .stroke(.white, lineWidth: 1.0)
                }
                .foregroundColor(.white)
        }
        .foregroundColor(.black)
    }
}
