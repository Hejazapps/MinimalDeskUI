//
//  OnboardingGrow.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 8/12/24.
//

import SwiftUI

struct OnboardingGrow: View {
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("onboarding5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 0.4, height: screenHeight * 0.2)
                    .clipShape(.circle)
                Text("Help us grow")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                Text("Show love by giving us a review")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                Text("on app store")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    OnboardingGrow()
}
