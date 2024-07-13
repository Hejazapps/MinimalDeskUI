//
//  ContentView.swift
//  MinimalDesk
//
//  Created by Sadiqul Amin on 6/7/24.
//

import SwiftUI
import TabBarModule
 
import Combine
import Firebase



struct AppListView: View {
    
    @ObservedObject private var viewModel: FirebaseDataViewModel

    @State var widthToSet:CGFloat =  0
    @State var heightToSet:CGFloat =  0
    @State var gap:CGFloat = 0
    
    
    init(viewModel: FirebaseDataViewModel) {
        print("[FirebaseDataView] IN")
        
        self.viewModel = viewModel
        viewModel.fetchAllSubscribers()
    }
   
    
    var body: some View {
        VStack {
            
            Color.black.edgesIgnoringSafeArea(.all)
            Spacer()
            
            
            Spacer() // Pushes the following view to the bottom
            

           
           
        } .background(Color.black)
            
        .onAppear {
            
             
           
        }
        
        
    }
}

#Preview {
    AppListView(viewModel: FirebaseDataViewModel())
}
