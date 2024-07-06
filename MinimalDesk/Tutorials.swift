
//
//  CategoryListView.swift
//  OutletExpense
//
//  Created by Mamunur Rahaman on 8/17/23.
//

import SwiftUI


struct Tutorials: View {
    
    @Environment(\.colorScheme) var colorScheme

    
   
    var body: some View {
        ZStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                
            }
           
        }
        .edgesIgnoringSafeArea(.all)
        .background(colorScheme == .dark ? Color.black : Color.black)
        .onAppear {
             print("it has been called")
        }
        
    }
    
}

struct Tutorials_Previews: PreviewProvider {
    static var previews: some View {
        Tutorials()
    }
}

