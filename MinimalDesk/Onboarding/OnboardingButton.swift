//
//  OnboardingContinue.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 8/12/24.
//

import SwiftUI

struct OnboardingButton: View {
    var text: String = "Continue"
    var bgOpacity = 1.0
    
    var body: some View {
        Text(text)
            .foregroundStyle(Color.black)
            .font(.system(size: 20, weight: .medium))
            .frame(width: UIScreen.main.bounds.width * 0.90, height: 50)
            .background(Color.white.opacity(bgOpacity))
            .cornerRadius(15)
            .padding(.bottom, 20)
    }
}

#Preview {
    OnboardingButton()
}
