//
//  OnboardingMeet.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 8/12/24.
//

import SwiftUI

struct OnboardingMeet: View {
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("onboarding2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 0.75, height: screenHeight * 0.6)
                    .padding(.bottom, 10)
                Text("Meet your minimal, new")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20, weight: .medium))
                Text("Less Phone")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 30, weight: .bold))
            }
        }
    }
}

#Preview {
    OnboardingMeet()
}
