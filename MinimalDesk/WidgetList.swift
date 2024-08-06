//
//  WidgetList.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 17/7/24.
//

import SwiftUI
import WidgetKit

struct WidgetList: View {
    @Environment(\.dismiss) var dismiss
    private let userDefault: UserDefaults
    
    @State private var selectedTheme: String = ""
    @State private var shouldShowProgressView = false
    
    init() {
        self.userDefault = UserDefaults(suiteName: "group.minimaldesk") ?? UserDefaults()
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("Back")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    
                    Spacer()
                }
                .padding(.leading,15)
                
                Text("Choose a theme")
                    .font(.title2).bold()
                
                ScrollView(.vertical) {
                    DateTimeViewType1(height: 90.0)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25.0)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(isSelected(viewName: "DateTimeViewType1"), lineWidth: 2.0)
                        }
                        .onTapGesture {
                            doOnTap(theme: "DateTimeViewType1")
                        }
                        .padding()
                    
                    
                    
                    DateTimeViewType2()
                        .padding(.horizontal, 50)
                        .padding(.vertical, 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25.0)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(isSelected(viewName: "DateTimeViewType2"), lineWidth: 2.0)
                        }
                        .onTapGesture {
                            doOnTap(theme: "DateTimeViewType2")
                        }
                        .padding()
                    
                    DateTimeViewType3()
                        .padding(.horizontal, 35)
                        .padding(.vertical, 40)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25.0)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(isSelected(viewName: "DateTimeViewType3"), lineWidth: 2.0)
                        }
                        .onTapGesture {
                            doOnTap(theme: "DateTimeViewType3")
                        }
                        .padding()

                }
            }
            .foregroundColor(.white)
            
            if shouldShowProgressView {
                ZStack {
                    Color.black
                        .opacity(0.8)
                        .blur(radius: 3.0)
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                        .scaleEffect(3)
                }
            }
            
        }
    }
    
    private func isSelected(viewName: String) -> Color {
        selectedTheme == viewName ? .blue : .gray
    }
    
    private func showProgressView() {
        shouldShowProgressView = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.shouldShowProgressView = false
        }
    }
    
    private func doOnTap(theme: String) {
        userDefault.set(theme, forKey: "current-widget-theme")
        selectedTheme = theme
        WidgetCenter.shared.reloadTimelines(ofKind: "MinimalDeskDateWidget")
        
        showProgressView()
    }
}

#Preview {
    WidgetList()
}
