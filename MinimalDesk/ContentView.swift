//
//  ContentView.swift
//  MinimalDesk
//
//  Created by Sadiqul Amin on 6/7/24.
//

import SwiftUI
import TabBarModule


struct ContentView: View {
    @State private var item: Int = 0
    
    var body: some View {
        TabBar(selection: $item) {
            AddView()
                .tabItem(0) {
                    Image("Add")
                        .renderingMode(.template)
                        .foregroundColor(item == 0 ? .blue : .white)
                        .font(.title3)
                     Text("Add")
                        .font(.system(.footnote, design: .rounded).weight(item == 0 ? .bold : .medium))
                        .foregroundColor(item == 0 ? .blue : .white)
                        
                }
            
            Widget()
                .tabItem(1) {
                    Image("Widget")
                        .renderingMode(.template)
                        .foregroundColor(item == 1 ? .blue : .white)
                        .font(.title3)
                    Text("Widget")
                        .font(.system(.footnote, design: .rounded).weight(item == 1 ? .bold : .medium))
                        .foregroundColor(item == 1 ? .blue : .white)
                }
            Tutorials()
                .tabItem(2) {
                    Image("Tutorials")
                        .renderingMode(.template)
                        .foregroundColor(item == 2 ? .blue : .white)
                        .font(.title3)
                    Text("Tutorials")
                        .font(.system(.footnote, design: .rounded).weight(item == 2 ? .bold : .medium))
                        .foregroundColor(item == 2 ? .blue : .white)
                }
            Settings()
                .tabItem(3) {
                    Image("Settings")
                        .renderingMode(.template)
                        .foregroundColor(item == 3 ? .blue : .white)
                        .font(.title3)
                    Text("Settings")
                        .font(.system(.footnote, design: .rounded).weight(item == 3 ? .bold : .medium))
                        .foregroundColor(item == 3 ? .blue : .white)
                }
            
            
        } .tabBarFill(.linearGradient(
            colors: [.black, .black],
            startPoint: .top, endPoint: .bottom))
         

    }
}

#Preview {
    ContentView()
}
