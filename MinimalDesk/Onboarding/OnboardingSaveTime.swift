//
//  SwiftUIView.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 8/12/24.
//

import SwiftUI

struct OnboardingSaveTime: View {
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("onboarding3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.3)
                
                Text("Save your time")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.white)
                Text("With Less Phone")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(Color.white)
                    .opacity(0.6)
                    .padding(.bottom, 25)
                
                rectungularBox(with: "Reimagine your device as a tool,", and: "not a distraction")
                rectungularBox(with: "Science based method to reduce", and: "screen time.")
                rectungularBox(with: "Utilize 'Less Phone' to refine", and: "your life's focus.")
            }
        }
    }
    
    private func rectungularBox(with upperText: String, and lowerText: String) -> some View {
        Rectangle()
            .stroke(Color.white, lineWidth: 1)
            .frame(width: screenWidth * 0.9, height: 60)
            .padding(.bottom, 10)
            .cornerRadius(2)
            .opacity(0.2)
            .overlay(
                HStack(spacing: 0) {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 15)
                    
                    VStack(alignment: .leading) {
                        Text(upperText)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                        Text(lowerText)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 10)
                    Spacer()
                }
            )
    }
}

#Preview {
    OnboardingSaveTime()
}
