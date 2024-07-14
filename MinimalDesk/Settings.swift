
//
//  CategoryListView.swift
//  OutletExpense
//
//  Created by Mamunur Rahaman on 8/17/23.
//

import SwiftUI


struct Settings: View {
    
    @Environment(\.colorScheme) var colorScheme

    
   
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                 
                Text("Settings").bold()
                    .foregroundColor(Color.white).font(.system(size: 40))
                
            }
           
        }
        .edgesIgnoringSafeArea(.all)
        .background(colorScheme == .dark ? Color.black : Color.black)
        .onAppear {
             print("it has been called")
        }
        
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
