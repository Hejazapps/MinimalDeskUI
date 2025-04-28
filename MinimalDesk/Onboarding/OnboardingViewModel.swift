//
//  File.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 9/12/24.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    static let shared = OnboardingViewModel()
    private init() { }
    
    @Published var signal: Bool = false
    
    @Published var selectedAppName: [String] = [] {
        didSet {
            if selectedAppName.count > 0 {
                signal = true
            } else {
                signal = false
            }
        }
    }
}
