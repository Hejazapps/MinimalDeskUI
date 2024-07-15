
//
//  CategoryListView.swift
//  OutletExpense
//
//  Created by Mamunur Rahaman on 8/17/23.
//

import SwiftUI


struct AddCustom: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var favoriteColor = 0
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""

    
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing:15) {
                
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("Back")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                    
                    Spacer()
                    Text("AddCustom").bold().foregroundColor(Color.white)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Add")
                            .padding()
                            .foregroundColor(Color(red: 138/255, green: 196/255, blue: 75/255))
                            .padding(.trailing,15)
                        
                    }
                }
                .padding(.leading,15)
                
                
                TextField("", text: $searchText,prompt: Text("AppName").foregroundColor(Color(red: 137 / 255, green: 137 / 255, blue: 137 / 255)))
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 26 / 255, green: 26 / 255, blue: 26 / 255))
                    )
                    .foregroundColor(.white)
                
                    .padding([.top, .horizontal])
                
            }
            .edgesIgnoringSafeArea(.all)
            .background(colorScheme == .dark ? Color.black : Color.black)
            .onAppear {
                print("it has been called")
            }
            
        }
    }
    
}

struct AddCustom_Previews: PreviewProvider {
    static var previews: some View {
        AddCustom()
    }
}
