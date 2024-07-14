
//
//  CategoryListView.swift
//  OutletExpense
//
//  Created by Mamunur Rahaman on 8/17/23.
//

import SwiftUI


struct Settings: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var favoriteColor = 0
    
    private let colors = ["System", "Dark", "Light"]
    let items = ["Email", "Telegram", "Give us a 5-star review", "Share to Friends","Frequently Asked Questions"]
    
    
    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            ScrollView {
                
                VStack(spacing: 15) {
                    
                    Text("Settings").bold()
                        .foregroundColor(Color.white).font(.system(size: 25))
                        .padding(.top,10)
                    
                    Image("topView")
                        .resizable()
                        .frame(width: screenWidth * 0.9, height: getHeight())
                    
                    Text("Themes").foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading).padding(.leading,20)
                    
                    ZStack {
                        
                        Color(red: 25.0 / 255, green: 25.0 / 255, blue: 25.0 / 255).edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                                ForEach(0..<colors.count) { index in
                                    Text(colors[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .foregroundColor(.white) // Default text color
                            
                            // Custom segmented control style
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(red: 39.0 / 255, green: 39.0 / 255, blue: 41.0 / 255)) // Selected segment color
                            )
                            
                            .padding(.horizontal)
                            
                            .onAppear {
                                UISegmentedControl.appearance().selectedSegmentTintColor = .white
                                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
                            }
                        }.frame(width: screenWidth * 0.9)
                            .padding(.top,4)
                            .padding(.bottom,4)
                    }.cornerRadius(20)
                        .frame(height: 37)
                    
                    
                    ZStack {
                        
                        Color(red: 25.0 / 255, green: 25.0 / 255, blue: 25.0 / 255).edgesIgnoringSafeArea(.all)
                        HStack {
                            HStack {
                                Image("Rectangle")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                                Text("AppIcon")
                                    .foregroundColor(Color.white).font(.system(size: 14))
                            }.padding(.leading,15)
                            
                            Spacer()
                            
                            Image("arrow r")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing,15)
                            
                        }
                        
                    }.cornerRadius(20)
                        .frame(height: 37)
                    
                    ZStack {
                        
                        Color(red: 25.0 / 255, green: 25.0 / 255, blue: 25.0 / 255).edgesIgnoringSafeArea(.all)
                        VStack {
                            VStack {
                                
                                Text("Support & Others")
                                    .frame(maxWidth: .infinity, alignment: .leading).padding(.leading,20)
                                    .foregroundColor(Color.white)
                                    .padding(.top,10)
                            }
                            
                            ZStack {
                                
                                Color(red: 39.0 / 255, green: 39.0 / 255, blue: 41.0 / 255).edgesIgnoringSafeArea(.all)
                                
                                List(items, id: \.self) { item in
                                    HStack {
                                        Image(item) .frame(width: 30, height: 30)
                                        Text(item).foregroundColor(Color.white)
                                        Spacer() // Add spacer to push text to the leading edge
                                    }
                                    .padding()
                                    .background(Color(red: 39.0 / 255, green: 39.0 / 255, blue: 41.0 / 255).edgesIgnoringSafeArea(.all))
                                    .listRowInsets(EdgeInsets()) // Remove default padding
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)// Add vertical padding to each row
                                    .frame(height: 50)
                                }
                                .listStyle(PlainListStyle())
                                
                                
                            }.frame(height: 260)
                                .cornerRadius(20)
                                .padding(.leading,15)
                                .padding(.trailing,15)
                                .padding(.bottom,20)
                            
                            
                            
                        }
                        
                    }.cornerRadius(20)
                        .frame(height: 330)
                        .padding(.bottom,10)
                    
                    
                    

                    

                }
            }.frame(height: screenHeight - 150)
        }
        .edgesIgnoringSafeArea(.all)
        .background(colorScheme == .dark ? Color.black : Color.black)
        .onAppear {
            print("it has been called")
        }
        
    }
    func getHeight()->CGFloat {
        let value  = (screenWidth * 0.8 * 600)/1047
        return value
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
