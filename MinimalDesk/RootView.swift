//
//  ContentView.swift
//  MinimalDesk
//
//  Created by Sadiqul Amin on 6/7/24.
//

import SwiftUI
import TabBarModule

struct RootView: View {
    @State private var item: Int = 0
    @State private var hasTappedAppLocker = false  // Flag to track if AppLocker tab is tapped
    
    var body: some View {
        TabBar(selection: $item) {
            AddView()
                .tabItem(0) {
                    Image("Add")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(item == 0 ? .blue : .white)
                        .font(.title3)
                    Text("Add")
                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
                        .foregroundColor(item == 0 ? .blue : .white)
                        .padding(.top ,5)
                }
            
            Widget()
                .tabItem(1) {
                    Image("Widget")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(item == 1 ? .blue : .white)
                        .font(.title3)
                    Text("Widget")
                        .font(.system(.footnote, design: .rounded).weight(item == 1 ? .bold : .medium))
                        .foregroundColor(item == 1 ? .blue : .white)
                        .padding(.top ,5)
                }
            
            Tutorials()
                .tabItem(2) {
                    Image("Tutorials")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(item == 2 ? .blue : .white)
                        .font(.title3)
                    Text("Tutorials")
                        .font(.system(.footnote, design: .rounded).weight(item == 2 ? .bold : .medium))
                        .foregroundColor(item == 2 ? .blue : .white)
                        .padding(.top ,5)
                }
            
            AppLocker()
                .tabItem(3) {
                    Image(systemName: "lock.app.dashed")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(item == 3 ? .blue : .white)
                        .font(.largeTitle)
                    Text("Lock")
                        .font(.system(.footnote, design: .rounded).weight(item == 3 ? .bold : .medium))
                        .foregroundColor(item == 3 ? .blue : .white)
                        .padding(.top ,5)
                }
            
            Settings()
                .tabItem(4) {
                    Image("Settings")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(item == 4 ? .blue : .white)
                        .font(.title3)
                    Text("Settings")
                        .font(.system(.footnote, design: .rounded).weight(item == 4 ? .bold : .medium))
                        .foregroundColor(item == 4 ? .blue : .white)
                        .padding(.top ,5)
                }
        }
        .tabBarFill(
            .linearGradient(
                colors: [.black, .black],
                startPoint: .top, endPoint: .bottom
            )
        )
        .onChange(of: item) { newItem in
            if newItem == 3 && !hasTappedAppLocker {  // Check if it's the first tap on App Locker tab
                AppLockerViewModel.shared.requestAuthorization()
                hasTappedAppLocker = true  // Mark that App Locker tab has been tapped
            }
        }
    }
}

#Preview {
    RootView()
}
