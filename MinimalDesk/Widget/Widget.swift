//
//  ContentView.swift
//  MinimalDesk
//
//  Created by Sadiqul Amin on 6/7/24.
//

import SwiftUI
//import TabBarModule
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height


struct Widget: View {
    
    @State var widthToSet:CGFloat =  0
    @State var heightToSet:CGFloat =  0
    @State var gap:CGFloat = 0
    @State private var isPresented = false
    @State private var isWidgetListPresented = false
    
    
    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Image("banner")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 0.92, height: screenHeight * 0.15)
                    .cornerRadius(10)
                    .onTapGesture {
                        if let url = URL(string: "https://apps.apple.com/us/app/scannr-qr-barcode-generator/id6480269610") {
                            UIApplication.shared.open(url) // TODO: not opening
                        }
                    }
                
                Spacer()
                
                HStack(spacing:gap) {
                    
                    
                    
                    VStack(spacing: 8) {
                        Image("widghet") // Replace "yourImageName" with the name of your image asset
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                        
                        VStack(spacing: 0) {
                            Text("Customize")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("Widget")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .frame(width: widthToSet, height: heightToSet)
                    .background(Color(red: 41/255, green: 44/255, blue: 53/255))
                    .cornerRadius(10)
                    .gesture(TapGesture().onEnded {
                        isPresented = true
                    })
                    
                    .fullScreenCover(isPresented: $isPresented) {
                        CustomWidget()
                    }
                    
                    
                    VStack(spacing: 0) {
                        Image("widghet")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 35, height: 35)
                            .padding(8)
                        VStack(spacing: 0) {
                            Text("Top")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("Widgets")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        Spacer()
                    }
                    .frame(width: widthToSet, height: heightToSet)
                    .background(Color(red: 41/255, green: 44/255, blue: 53/255))
                    .cornerRadius(10)
                    
                    .onTapGesture {
                        isWidgetListPresented = true
                    }
                    
                    .fullScreenCover(isPresented: $isWidgetListPresented) {
                        WidgetList()
                    }
                    
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
}

#Preview {
    Widget()
}
