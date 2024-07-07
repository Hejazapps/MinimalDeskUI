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
    @State var gapNeedToGive:CGFloat = 0
    @Environment(\.dismiss) var dismiss
    @State var selectedColor =  Color.white
    @State var presentColorView = false
    @State var fontSize = 48
    
    var body: some View {
        
        VStack() {
            
            Color.black
            HStack {
                
                Spacer()
                VStack {
                    Button(action: {
                        dismiss()
                        // action to perform when the button is tapped
                    }) {
                        Image("roundedCross")
                            .resizable() // This allows the image to be resized
                            .frame(width: 30, height: 30) // This sets the size of the image
                    }
                }.padding(.trailing,30)
            }
            
            
            Text("Customize widgets")
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 30))
                .padding(.bottom,2*gap)
                .padding(.leading,1.2*gap)
                .bold()
            
            ScrollView {
                
                
                VStack(spacing: gap) {
                    
                    HStack(spacing:gap) {
                        
                        
                        
                        VStack {
                            HStack(alignment: .top) { // Align items to the top
                                Text("Top\n Wedget")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .padding(.leading)
                                    .bold()
                                
                                
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
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        
                        VStack() {
                            
                            HStack(alignment: .top) { // Align items to the top
                                Text("Custom\n Wallpaper")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .padding(.leading)
                                    .bold()
                                
                                Spacer()
                                
                                Image("arrow")
                                    .padding(.trailing)
                                    .padding(.top)
                            }.padding(.top,15)
                            
                            Spacer()
                            
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        
                    }
                    
                    HStack(spacing:gap) {
                        
                        
                        
                        VStack(spacing:0) {
                            
                            HStack(alignment: .top) { // Align items to the top
                                Text("Widget color")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .padding(.leading)
                                    .bold()
                                Spacer()
                                
                                
                            }.padding(.top,15)
                            
                            
                            
                            HStack(alignment: .top,spacing: 20) {
                                VStack {
                                    Image("e1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                    Text("Ash").foregroundColor(Color.white)
                                }
                                VStack {
                                    Image("e2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                    Text("Light").foregroundColor(Color.white)
                                }
                                VStack {
                                    
                                    Image("e3")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                    
                                    Text("Dark").foregroundColor(Color.white)
                                }
                            }.padding(.top,15)
                            
                            Spacer()
                            
                            
                            
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        VStack() {
                            
                            ZStack {
                                
                                VStack {
                                    
                                    HStack(alignment: .top) { // Align items to the top
                                        Text("Text color")
                                            .font(.headline)
                                            .foregroundColor(Color.white)
                                            .padding(.leading)
                                            .bold()
                                        Spacer()
                                        
                                        
                                    }.padding(.top,15)
                                    
                                    VStack {
                                        Image("e2")
                                            .renderingMode(.template)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color.black)
                                        
                                        Text("vvvvv").foregroundColor(Color.black)
                                    }.padding(.top,0)
                                }.overlay {
                                    ColorPicker("", selection: $selectedColor)
                                        .labelsHidden()
                                        .opacity(1.0)
                                        .padding(.top,10)
                                }
                            }
                            
                            Spacer()
                            
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        
                    }
                    
                    HStack(spacing:gap) {
                        
                        
                        
                        VStack() {
                            
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        VStack(spacing:0) {
                            
                            HStack(alignment: .top) { // Align items to the top
                                Text("Alignment")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .padding(.leading)
                                    .bold()
                                Spacer()
                                
                                
                            }.padding(.top,15)
                            
                            
                            
                            HStack(alignment: .top,spacing: 20) {
                                VStack {
                                    Image("a")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                    Text("Ash").foregroundColor(Color.black)
                                }
                                VStack {
                                    Image("b")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                    Text("Light").foregroundColor(Color.black)
                                }
                                VStack {
                                    
                                    Image("b")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                    
                                    Text("Dark").foregroundColor(Color.black)
                                }
                            }.padding(.top,15)
                            
                            Spacer()
                            
                            
                            
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        
                        
                        
                    }
                    
                    HStack(spacing:gap) {
                        
                        
                        
                        VStack() {
                            
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        VStack(spacing:0) {
                            
                            HStack(alignment: .top) { // Align items to the top
                                Text("Size")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20))
                                    .padding(.leading)
                                    .bold()
                                Spacer()
                                
                                
                            }.padding(.top,15)
                            
                            
                            
                            HStack(alignment: .top,spacing: 20) {
                                VStack {
                                    Image("minus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            
                                            if fontSize >= 11 {
                                                fontSize -= 1
                                            }
                                        }
                                }.padding(.top,30)
                                VStack {
                                    
                                    Text("\(fontSize)").foregroundColor(Color.white).bold()
                                        .font(.system(size: 25))
                                    
                                }.padding(.top,30)
                                VStack {
                                    
                                    Image("plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            
                                            if fontSize <= 60 {
                                                fontSize += 1
                                            }
                                        }
                                } .padding(.top,30)
                            }
                            
                            Spacer()
                            
                            
                            
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        
                        
                        
                    }
                    
                }.padding(.bottom,bottomGap > 0 ? bottomGap : 10)
                
            }
            .frame(height: screenHeight - 250)
            
            
            
            
        }   .background(Color.black)
        
        
            .onAppear {
                
                gap = 20.0
                widthToSet = (screenWidth - 3 * gap) / 2.0
                bottomGap = (screenHeight - 3 * widthToSet - 4*gap - 70) / 3.0
                gapNeedToGive = (screenWidth - 3*30)/3
                
                print("i have found \(gapNeedToGive) \(screenWidth)")
                
                
            }
        
        
    }
}

#Preview {
    CustomWidget()
}
