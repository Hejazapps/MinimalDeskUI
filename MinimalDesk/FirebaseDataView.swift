//
//  FirebaseDataView.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 12/7/24.
//

import SwiftUI

struct FirebaseDataView: View {
    @ObservedObject private var viewModel: FirebaseDataViewModel

    init(viewModel: FirebaseDataViewModel) {
        print("[FirebaseDataView] IN")
        
        self.viewModel = viewModel
        viewModel.fetchAllSubscribers()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack (alignment: .center) {
                Text("AppList")
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        print("[FirebaseDataView] Refreshed subscriber list.")
                        viewModel.fetchAllSubscribers()
                    }
            }
            .padding(.top)
            .padding(.horizontal)

            List(viewModel.appList) { subscriber in
                HStack (spacing: 10) {
                    Text(subscriber.appName)
                    
                    Spacer()
                    
                    Text(subscriber.appLink)
                }
            }
        }
    }
}

#Preview {
    FirebaseDataView(viewModel: FirebaseDataViewModel())
}
