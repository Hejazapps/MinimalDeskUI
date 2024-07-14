
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
    
    private let colors = ["Red", "Green", "Blue"]
    
    
    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                
                Text("Settings").bold()
                    .foregroundColor(Color.white).font(.system(size: 40))
                    .padding(.top,10)
                
                Image("topView")
                    .resizable()
                    .frame(width: screenWidth * 0.8, height: getHeight())
                
                Text("Themes").foregroundColor(Color.white)
                
                
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
                }.frame(width: screenWidth * 0.8)
                
               
                
                
                
            }
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
