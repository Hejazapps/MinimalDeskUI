//
//  ContentView.swift
//  MinimalDesk
//
//  Created by Sadiqul Amin on 6/7/24.
//

import SwiftUI
import TabBarModule




struct AddView: View {
    
    @State var widthToSet:CGFloat =  0
    @State var heightToSet:CGFloat =  0
    @State var gap:CGFloat = 0
    @State private var isDetailViewVisible = false
    
    
    
    var body: some View {
        VStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            Spacer()
            
            
            Spacer() // Pushes the following view to the bottom
            
            
            
            HStack(spacing:gap) {
                
                
                
                VStack(spacing: 8) {
                    Image("leftThumb") // Replace "yourImageName" with the name of your image asset
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                    
                    
                    
                    Text("Add Apps")
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    
                    Text("Add remove or reorder apps")
                        .font(.system(size: 10))
                        .foregroundColor(Color(red: 175.0/255, green: 175.0/255, blue: 179.0/255))
                }
                .frame(width: widthToSet, height: heightToSet)
                .background(Color(red: 41/255, green: 44/255, blue: 53/255))
                .cornerRadius(10)
                
                .onTapGesture {
                    self.isDetailViewVisible.toggle()
                }
                
                
                .fullScreenCover(isPresented: $isDetailViewVisible) {
                    AppListView(viewModel:  FirebaseDataViewModel())
                }
                
                VStack(spacing: 8) {
                    
                    Image("RightThumb") // Replace "yourImageName" with the name of your image asset
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                    
                    Text("Add Custom")
                        .font(.headline)
                        .foregroundColor(Color.white)
                    
                    
                    Text("Add apps by using URL Schemes")
                        .font(.system(size: 10))
                        .foregroundColor(Color(red: 175.0/255, green: 175.0/255, blue: 179.0/255))
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
    AddView()
}
