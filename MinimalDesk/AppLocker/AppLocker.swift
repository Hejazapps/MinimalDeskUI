//
//  AppLocker.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 19/10/24.
//

import SwiftUI
//
//struct AppLocker: View {
//    private let sliderWidth = screenWidth - 100
//    private let sliderHeight = 70.0
//    
//    @State private var sliderOffset = 0.0
//    @State private var isLocked = false
//    @State private var isFamilyActivityPickerPresented = false
//    
//    @ObservedObject private var viewModel = AppLockerViewModel.shared
//    
//    var body: some View {
//        ZStack {
//            Color.black.edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                // MARK: - Header
//                VStack(alignment: .leading) {
//                    Text("Lock Distractions")
//                        .font(.largeTitle)
//                    
//                    Text("Choose the distracting apps you want to lock.")
//                        .foregroundStyle(.gray)
//                }
//                .padding()
//                
//                Spacer()
//                
//                // MARK: - Select Apps
//                HStack {
//                    Text(viewModel.selectedTokens.isEmpty ? "Select Apps" : "Apps Selected")
//                        .font(.title2)
//                        .padding(.horizontal)
//                    
//                    Spacer()
//                    
//                    if viewModel.selectedTokens.isEmpty {
//                        Image(systemName: "plus.square")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 45)
//                            .padding(.horizontal)
//                    } else {
//                        ForEach (viewModel.selectedTokens.prefix(4), id: \.self) { type in
//                            switch type {
//                            case .application(let token):
//                                Label(token).labelStyle(.iconOnly)
//                                
//                            case .category(let token):
//                                Label(token).labelStyle(.iconOnly)
//                            }
//                        }
//                    }
//                }
//                .padding()
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
//                .contentShape(RoundedRectangle(cornerRadius: 10))
//                .padding()
//                .onTapGesture {
//                    isFamilyActivityPickerPresented = true
//                }
//                .familyActivityPicker(isPresented: $isFamilyActivityPickerPresented, selection: $viewModel.activitySelection)
//                
//                Spacer()
//                
//                // MARK: - Lock Slider
//                ZStack {
//                    HStack {
//                        Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .offset(x: sliderOffset)
//                            .gesture(
//                                DragGesture()
//                                    .onChanged({ value in
//                                        let offset = isLocked ? value.translation.width + (sliderWidth - sliderHeight) : value.translation.width
//                                        guard offset >= 0 && offset <= sliderWidth - sliderHeight else { return }
//                                        sliderOffset = offset
//                                    })
//                                    .onEnded({ value in
//                                        let offset = isLocked ? value.translation.width + (sliderWidth - sliderHeight) : value.translation.width
//                                        withAnimation(.easeIn(duration: 0.3)) {
//                                            sliderOffset = offset >= (sliderWidth - sliderHeight) / 2 ? sliderWidth - sliderHeight : 0
//                                        } completion: {
//                                            isLocked = sliderOffset == (sliderWidth - sliderHeight)
//                                        }
//                                    })
//                            )
//                            .padding()
//                        
//                        Spacer()
//                    }
//                    .frame(width: sliderWidth, height: sliderHeight)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
//                    .padding()
//                    
//                    HStack {
//                        if sliderOffset == (sliderWidth - sliderHeight) {
//                            Text("<< Slide to unlock")
//                                .padding(.leading)
//                        }
//                        
//                        Spacer()
//                        
//                        if sliderOffset == 0 {
//                            Text("Slide to lock >>")
//                                .padding(.trailing)
//                        }
//                    }
//                    .frame(width: sliderWidth, height: sliderHeight)
//                }
//                .padding()
//            }
//        }
//        .foregroundStyle(.white)
//        .onAppear {
//            viewModel.requestAuthorization()
//            isLocked = viewModel.appLockStatus
//            if isLocked { sliderOffset = (sliderWidth - sliderHeight) }
//        }
//        .onChange(of: isLocked) {
//            viewModel.toggleAppRestriction(lock: isLocked)
//        }
//        .onChange(of: viewModel.activitySelection) { _, _ in
//            viewModel.toggleAppRestriction(lock: isLocked)
//            viewModel.saveSelection()
//        }
//    }
//}
//
//#Preview {
//    AppLocker()
//}



struct AppLocker: View {
    private let sliderWidth = screenWidth - 100
    private let sliderHeight = 70.0
    
    @State private var sliderOffset = 0.0
    @State private var isLocked = false
    @State private var isFamilyActivityPickerPresented = false
    
    @ObservedObject private var viewModel = AppLockerViewModel.shared
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                // MARK: - Header
                VStack(alignment: .leading) {
                    Text("Lock Distractions")
                        .font(.largeTitle)
                    
                    Text("Choose the distracting apps you want to lock.")
                        .foregroundStyle(.gray)
                }
                .padding()
                
                Spacer()
                
                // MARK: - Select Apps
                HStack {
                    Text(viewModel.selectedTokens.isEmpty ? "Select Apps" : "Apps Selected")
                        .font(.title2)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    if viewModel.selectedTokens.isEmpty {
                        Image(systemName: "plus.square")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45)
                            .padding(.horizontal)
                    } else {
                        ForEach(viewModel.selectedTokens.prefix(4), id: \.self) { type in
                            switch type {
                            case .application(let token):
                                Label(token).labelStyle(.iconOnly)
                            case .category(let token):
                                Label(token).labelStyle(.iconOnly)
                            }
                        }
                    }
                }
                .padding()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                .contentShape(RoundedRectangle(cornerRadius: 10))
                .padding()
                .onTapGesture {
                    isFamilyActivityPickerPresented = true
                }
                .familyActivityPicker(isPresented: $isFamilyActivityPickerPresented, selection: $viewModel.activitySelection)
                
                Spacer()
                
                // MARK: - Lock Slider
                ZStack {
                    HStack {
                        Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                            .resizable()
                            .scaledToFit()
                            .offset(x: sliderOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                        let offset = isLocked ? value.translation.width + (sliderWidth - sliderHeight) : value.translation.width
                                        guard offset >= 0 && offset <= sliderWidth - sliderHeight else { return }
                                        sliderOffset = offset
                                    })
                                    .onEnded({ value in
                                        let offset = isLocked ? value.translation.width + (sliderWidth - sliderHeight) : value.translation.width
                                        withAnimation(.easeIn(duration: 0.3)) {
                                            sliderOffset = offset >= (sliderWidth - sliderHeight) / 2 ? sliderWidth - sliderHeight : 0
                                        } completion: {
                                            isLocked = sliderOffset == (sliderWidth - sliderHeight)
                                        }
                                    })
                            )
                            .padding()
                        
                        Spacer()
                    }
                    .frame(width: sliderWidth, height: sliderHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                    .padding()
                    
                    HStack {
                        if sliderOffset == (sliderWidth - sliderHeight) {
                            Text("<< Slide to unlock")
                                .padding(.leading)
                        }
                        
                        Spacer()
                        
                        if sliderOffset == 0 {
                            Text("Slide to lock >>")
                                .padding(.trailing)
                        }
                    }
                    .frame(width: sliderWidth, height: sliderHeight)
                }
                .padding()
            }
        }
        .foregroundStyle(.white)
        .onAppear {
            isLocked = viewModel.appLockStatus
            if isLocked { sliderOffset = (sliderWidth - sliderHeight) }
        }
        .onChange(of: isLocked) {
            viewModel.toggleAppRestriction(lock: isLocked)
        }
        .onChange(of: viewModel.activitySelection) { _, _ in
            viewModel.toggleAppRestriction(lock: isLocked)
            viewModel.saveSelection()
        }
    }
}

#Preview {
    AppLocker()
}
