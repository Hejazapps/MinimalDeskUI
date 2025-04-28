//
//  OnboardingThieves.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 8/12/24.
//

import SwiftUI

struct OnboardingThieves: View {
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("onboarding1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 0.75, height: screenHeight * 0.6)
                    .padding(.bottom, 10)
                Text("Screens are digital thieves,")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20, weight: .medium))
                Text("stealing our focus")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20, weight: .medium))
                Text("and productivity")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20, weight: .medium))
            }
        }
    }
}

#Preview {
    OnboardingThieves()
}
