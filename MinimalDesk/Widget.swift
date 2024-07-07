//
//  ContentView.swift
//  MinimalDesk
//
//  Created by Sadiqul Amin on 6/7/24.
//

import SwiftUI
import TabBarModule
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height


struct Widget: View {
    
    @State var widthToSet:CGFloat =  0
    @State var heightToSet:CGFloat =  0
    @State var gap:CGFloat = 0
    @State private var isPresented = false

    
    
    var body: some View {
        VStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            Spacer()
            
            
            Spacer() // Pushes the following view to the bottom
            
            
            
            HStack(spacing:gap) {
                
                
                
                VStack(spacing: 8) {
                    Image("widghet") // Replace "yourImageName" with the name of your image asset
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                    
                    
                    
                    Text("Customize\n Wedget")
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    
                    
                }
                .frame(width: widthToSet, height: heightToSet)
                .background(Color(red: 41/255, green: 44/255, blue: 53/255))
                .cornerRadius(10)
                .gesture(TapGesture().onEnded {
                    isPresented = true
                })
                .sheet(isPresented: $isPresented, content: {
                    // Content of the sheet view you want to present
                    CustomWidget()
                })
                VStack(spacing: 8) {
                    
                    Image("widghet") // Replace "yourImageName" with the name of your image asset
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                    
                    Text("Customize\nTop Wedget")
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    
                    
                }
                .frame(width: widthToSet, height: heightToSet)
                .background(Color(red: 41/255, green: 44/255, blue: 53/255))
                .cornerRadius(10)
                
                
            }.padding(.bottom,40)
            
            
        } .background(Color.black)
        
            .onAppear {
                
                widthToSet = (screenWidth * 0.85)/2.0
                gap = (screenWidth - widthToSet * 2)/3.0
                heightToSet = (112 * widthToSet) / 176.0
                // Perform any actions you want when the view appears
            }
        
        
    }
}

#Preview {
    Widget()
}
