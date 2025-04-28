//
//  ToastView.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 23/9/24.
//
import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color.black.opacity(0.7))
                .cornerRadius(25)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .transition(.opacity)
    }
}
