//
//  OnboardingEssentials.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 8/12/24.
//

import SwiftUI

struct OnboardingEssentials: View {
    @ObservedObject var viewModel = OnboardingViewModel.shared
    @State private var searchText = ""
    
    var filteredApps: [String] {
        if searchText.isEmpty {
            return FirebaseDataViewModel.shared.onlyAppName
        } else {
            return FirebaseDataViewModel.shared.onlyAppName.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Pick Essential Apps")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("Let's start with these apps. You can")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .fontWeight(.regular)
                Text("change them later")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .fontWeight(.regular)
                
                searchBox()
                
                List(filteredApps, id: \.self) { appName in
                    HStack {
                        Text(appName)
                            .foregroundStyle(.white)
                            .font(.headline)
                            .fontWeight(.light)
                            .padding()
                        Spacer()
                        Button(action: {
                            toggleSelection(for: appName)
                        }) {
                            Image(systemName: viewModel.selectedAppName.contains(appName) ? "checkmark" : "plus")
                                .foregroundColor(viewModel.selectedAppName.contains(appName) ? .green : .white)
                                .font(.title2)
                        }
                        .padding()
                    }
                    .listRowBackground(Color.gray.opacity(0.2))
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                    )
                    .listRowInsets(EdgeInsets())
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    private func toggleSelection(for appName: String) {
        if let index = viewModel.selectedAppName.firstIndex(of: appName) {
            viewModel.selectedAppName.remove(at: index)
        } else if viewModel.selectedAppName.count < 6 {
            viewModel.selectedAppName.append(appName)
        }
    }
    
    private func searchBox() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 10)
            
            TextField("", text: $searchText)
                .placeholder(when: searchText.isEmpty) {
                    Text("Search an app name")
                        .foregroundColor(.white.opacity(0.6))
                        .fontWeight(.regular)
                }
                .foregroundColor(.white)
                .padding(10)
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    OnboardingEssentials(viewModel: OnboardingViewModel.shared)
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}
