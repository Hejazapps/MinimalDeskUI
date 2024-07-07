//
//  ContentView.swift
//  MinimalDesk
//
//  Created by Sadiqul Amin on 6/7/24.
//

import SwiftUI



struct CustomWidget: View {
    @State var heightToSet:CGFloat =  0
    @State var widthToSet:CGFloat =  0
    @State var gap:CGFloat = 0
    @State var bottomGap:CGFloat = 0
    
    var body: some View {
        
        VStack() {
            
            Color.black
            
            Text("Customize widgets")
                .foregroundColor(Color.white)
                .frame(width: screenWidth)
                .font(.system(size: 30))
                .padding(.bottom,2*gap)
                .bold()
            
            
            
            VStack(spacing: gap) {
                
                HStack(spacing:gap) {
                    
                    
                    
                    VStack {
                        HStack(alignment: .top) { // Align items to the top
                            Text("Top\n Wedget")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding(.leading)
                            
                            Spacer()
                            
                            Image("arrow")
                                .padding(.trailing)
                                .padding(.top)
                        }.padding(.top,15)
                        
                        Spacer()
                        
                       
                    }
                    .frame(width: widthToSet, height: widthToSet)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 41/255, green: 44/255, blue: 53/255), lineWidth: 1)
                    )
                    
                    VStack() {
                        
                        
                    }
                    .frame(width: widthToSet, height: widthToSet)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 41/255, green: 44/255, blue: 53/255), lineWidth: 1)
                    )
                    .cornerRadius(10)
                    
                    
                }
                
                HStack(spacing:gap) {
                    
                    
                    
                    VStack() {
                        
                    }
                    .frame(width: widthToSet, height: widthToSet)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 41/255, green: 44/255, blue: 53/255), lineWidth: 1)
                    )
                    .cornerRadius(10)
                    
                    VStack() {
                        
                        
                    }
                    .frame(width: widthToSet, height: widthToSet)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 41/255, green: 44/255, blue: 53/255), lineWidth: 1)
                    )
                    .cornerRadius(10)
                    
                    
                }
                
                HStack(spacing:gap) {
                    
                    
                    
                    VStack() {
                        
                    }
                    .frame(width: widthToSet, height: widthToSet)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 41/255, green: 44/255, blue: 53/255), lineWidth: 1)
                    )
                    .cornerRadius(10)
                    
                    VStack() {
                        
                        
                    }
                    .frame(width: widthToSet, height: widthToSet)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(red: 41/255, green: 44/255, blue: 53/255), lineWidth: 1)
                    )
                    .cornerRadius(10)
                    
                    
                }
                
            }.padding(.bottom,bottomGap > 0 ? bottomGap : 10)
            
            
            
        }   .background(Color.black)
        
        
            .onAppear {
                
                gap = 20.0
                widthToSet = (screenWidth - 3 * gap) / 2.0
                bottomGap = (screenHeight - 3 * widthToSet - 4*gap - 70) / 3.0
                
                print("i found \(bottomGap)")
                
                
            }
        
        
    }
}

#Preview {
    Widget()
}
