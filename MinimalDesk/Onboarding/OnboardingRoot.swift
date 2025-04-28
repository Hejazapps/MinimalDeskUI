//
//  OnboardingScreen.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 8/12/24.
//

import SwiftUI
import StoreKit

struct OnboardingRoot: View {
    @State private var currentPage = 0
    @State private var showRatingPopUp: Bool = false
    @ObservedObject private var viewModel = OnboardingViewModel.shared
    @AppStorage(UserDefaultsKeys.onboardingCompleted.rawValue) private var onboardingCompleted = false
    
    private let onboardingScreens: [AnyView] = [
        AnyView(OnboardingThieves()),
        AnyView(OnboardingMeet()),
        AnyView(OnboardingSaveTime()),
        AnyView(OnboardingEssentials()),
        AnyView(OnboardingGrow())
    ]
    
    private var onboardingButtonText: String {
        if currentPage == 3 {
            return "Select Apps"
        } else if currentPage == 4 && !showRatingPopUp{
            return "Help us grow"
        } else if showRatingPopUp {
            return "Next"
        } else {
            return "Continue"
        }
    }
    private var bgOpacity: Double {
        if currentPage == 3 && viewModel.signal == false {
            return 0.3
        } else {
            return 1.0
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    ForEach(0..<onboardingScreens.count, id: \.self) { index in
                        if index == currentPage {
                            onboardingScreens[index]
                                .transition(.move(edge: .trailing))
                                .animation(.easeInOut, value: currentPage)
                        }
                    }
                }
                
                Spacer()
                
                OnboardingButton(text: onboardingButtonText, bgOpacity: bgOpacity)
                    .onTapGesture {
                        withAnimation {
                            if currentPage == 3 && viewModel.signal == false {
                                // do nothing
                            } else if currentPage < onboardingScreens.count - 1 {
                                currentPage += 1
                            } else if !showRatingPopUp {
                                showRatingPopUp = true
                                showRatingPrompt()
                            } else {
                                UserDefaults.standard.set(viewModel.selectedAppName, forKey: UserDefaultsKeys.initallySelectedFavApps.rawValue)
                                onboardingCompleted = true
                            }
                        }
                    }
            }
        }
    }
    
    private func showRatingPrompt() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    OnboardingRoot()
}
