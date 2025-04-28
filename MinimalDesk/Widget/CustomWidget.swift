//
//  ContentView.swift
//  MinimalDesk
//
//  Created by Sadiqul Amin on 6/7/24.
//

import SwiftUI
import Firebase



struct CustomWidget: View {
    @Environment(\.dismiss) var dismiss
    
    @State var heightToSet:CGFloat =  0
    @State var widthToSet:CGFloat =  0
    @State var gap:CGFloat = 0
    @State var bottomGap:CGFloat = 0
    @State var gapNeedToGive:CGFloat = 0
    
    @State var widgetBackground: String
    @State var fontColor: Color
    @State var fontType: String
    @State var alignment: String
    @State var space: Double
    @State var fontSize: Int
    @State var widget: Int
    
    @State var presentColorView = false
    @State private var isWidgetListPresented = false
    @State private var isCustomWallPaperPressed = false
    @State private var isFontListPresented = false
    @State private var isDoneButtonDisabled = true
    
    private let viewModel = WidgetViewModel.shared
    
    init() {
        widgetBackground = viewModel.favAppWidgetConfig.backgroundColor
        fontColor = Color(hex: viewModel.favAppWidgetConfig.fontColor)
        fontType = viewModel.favAppWidgetConfig.fontType
        alignment = viewModel.favAppWidgetConfig.alignment
        space = viewModel.favAppWidgetConfig.spacing
        fontSize = viewModel.favAppWidgetConfig.fontSize
        widget = viewModel.favAppWidgetConfig.maxNumberOfApps
    }
    
    var body: some View {
        VStack() {
            Color.black
            
            // MARK: - Close Button
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image("roundedCross")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.trailing,30)
            }
            
            
            Text("Customize widgets")
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 30))
                .padding(.bottom,2*gap)
                .padding(.leading,1.2*gap)
                .bold()
            
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: gap) {
                    
                    // MARK: - First Row
                    HStack(spacing:gap) {
                        
                        // MARK: - Custom Wallpaper
                        VStack() {
                            HStack(alignment: .top) {
                                Text("Custom\nWallpaper")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .padding(.leading)
                                    .bold()
                                
                                Spacer()
                                
                                Image("arrow")
                                    .padding(.trailing)
                                    .padding(.top)
                            }.padding(.top,15)
                            
                            Spacer()
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            isCustomWallPaperPressed = true
                        }
                        .fullScreenCover(isPresented: $isCustomWallPaperPressed) {
                            CustomWallpaper()
                        }
                        
                        // MARK: - Widget Color
                        VStack(spacing:0) {
                            HStack(alignment: .top) { // Align items to the top
                                Text("Widget color")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .padding(.leading)
                                    .bold()
                                
                                Spacer()
                            }.padding(.top,15)
                            
                            HStack(alignment: .top,spacing: 20) {
                                VStack {
                                    Image("e1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .overlay {
                                            Circle()
                                                .stroke(isSelected(value1: widgetBackground, value2: "#212121"), lineWidth: 2)
                                        }
                                    
                                    Text("Ash").foregroundColor(Color.white)
                                }
                                .onTapGesture { widgetBackground = "#212121" }
                                
                                VStack {
                                    Image("e2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .overlay {
                                            Circle()
                                                .stroke(isSelected(value1: widgetBackground, value2: "#FFFFFF"), lineWidth: 2)
                                        }
                                    
                                    Text("Light").foregroundColor(Color.white)
                                }
                                .onTapGesture { widgetBackground = "#FFFFFF" }
                                
                                VStack {
                                    
                                    Image("e3")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .overlay {
                                            Circle()
                                                .stroke(isSelected(value1: widgetBackground, value2: "#000000"), lineWidth: 2)
                                        }
                                    
                                    Text("Dark").foregroundColor(Color.white)
                                }
                                .onTapGesture { widgetBackground = "#000000" }
                                
                            }
                            .padding(.top,15)
                            .onChange(of: widgetBackground) { _, _ in
                                guard viewModel.favAppWidgetConfig.backgroundColor != widgetBackground else { return }
                                
                                viewModel.favAppWidgetConfig.backgroundColor = widgetBackground
                                isDoneButtonDisabled = false
                            }
                            
                            Spacer()
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                    }
                    
                    // MARK: - Second Row
                    HStack(spacing:gap) {
                        
                        
                        // MARK: - Text Color
                        VStack {
                            ZStack(alignment: .top) {
                                HStack(alignment: .top) {
                                    Text("Text color")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                        .padding(.leading)
                                        .bold()
                                    
                                    Spacer()
                                }
                                .padding(.top, 15)
                                
                                VStack {
                                    Spacer()
                                    
                                    ColorPicker("", selection: $fontColor)
                                        .labelsHidden()
                                        .scaleEffect(2)
                                        .opacity(1.0)
                                        .padding(.top,10)
                                        .onChange(of: fontColor) { _, _ in
                                            guard let fontColorHex = fontColor.toHex(),
                                                  fontColorHex != viewModel.favAppWidgetConfig.fontColor else { return }
                                            
                                            viewModel.favAppWidgetConfig.fontColor = fontColorHex
                                            isDoneButtonDisabled = false
                                        }
                                    
                                    Spacer()
                                }
                            }
                            
                            Spacer()
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        
                        // MARK: - Font List
                        ZStack(alignment: .topLeading) {
                            HStack {
                                Text("Font")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .bold()
                                    .padding()
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .center) {
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    Text(fontType)
                                        .font(Font.custom(viewModel.favAppWidgetConfig.fontType, size: 14))
                                        .foregroundStyle(Color.white)
                                        .underline()
                                        .multilineTextAlignment(.center)
                                    
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            isFontListPresented = true
                        }
                        .fullScreenCover(isPresented: $isFontListPresented) {
                            guard fontType != viewModel.favAppWidgetConfig.fontType else { return }
                            
                            fontType = viewModel.favAppWidgetConfig.fontType
                            isDoneButtonDisabled = false
                        } content: {
                            FontListView()
                        }
                    }
                    
                    //MARK: - Third Row
                    HStack(spacing:gap) {
                        
                        
                        // MARK: - Alignment
                        VStack(spacing:0) {
                            HStack(alignment: .top) {
                                Text("Alignment")
                                    .font(.headline)
                                    .foregroundColor(Color.white)
                                    .padding(.leading)
                                    .bold()
                                
                                Spacer()
                            }.padding(.top,15)
                            
                            HStack(alignment: .top,spacing: 20) {
                                Image("a")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(isSelected(value1: alignment, value2: "left"), lineWidth: 2)
                                    }
                                    .onTapGesture { alignment = "left" }
                                
                                Image("b")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(isSelected(value1: alignment, value2: "center"), lineWidth: 2)
                                    }
                                    .onTapGesture { alignment = "center" }
                                
                                Image("c")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(isSelected(value1: alignment, value2: "right"), lineWidth: 2)
                                    }
                                    .onTapGesture { alignment = "right" }
                                
                            }
                            .padding(.top,15)
                            .onChange(of: alignment) { _, _ in
                                guard alignment != viewModel.favAppWidgetConfig.alignment else { return }
                                
                                viewModel.favAppWidgetConfig.alignment = alignment
                                isDoneButtonDisabled = false
                            }
                            
                            Spacer()
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        // MARK: - Spacing
                        VStack(spacing:0) {
                            HStack(alignment: .top) {
                                Text("Spacing")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20))
                                    .padding(.leading)
                                    .bold()
                                
                                Spacer()
                            }
                            .padding(.top,15)
                            
                            HStack(alignment: .top,spacing: 20) {
                                VStack {
                                    Image("minus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            if space > 0 {
                                                space -= 1
                                            }
                                        }
                                }.padding(.top,30)
                                VStack {
                                    Text("\(Int(space))").foregroundColor(Color.white).bold()
                                        .font(.system(size: 25))
                                    
                                }.padding(.top,30)
                                VStack {
                                    
                                    Image("plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            if space <= 15 {
                                                space += 1
                                            }
                                        }
                                } .padding(.top,30)
                            }
                            .onChange(of: space) { _, _ in
                                guard space != viewModel.favAppWidgetConfig.spacing else { return }
                                
                                viewModel.favAppWidgetConfig.spacing = space
                                isDoneButtonDisabled = false
                            }
                            
                            Spacer()
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                    }
                    
                    
                    // MARK: - Fourth Row
                    HStack(spacing:gap) {
                        
                        
                        // MARK: - Size
                        VStack(spacing:0) {
                            HStack(alignment: .top) {
                                Text("Size")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20))
                                    .padding(.leading)
                                    .bold()
                                
                                Spacer()
                            }
                            .padding(.top,15)
                            
                            HStack(alignment: .top,spacing: 20) {
                                VStack {
                                    Image("minus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            if fontSize > 10 {
                                                fontSize -= 1
                                            }
                                        }
                                }.padding(.top,30)
                                VStack {
                                    
                                    Text("\(fontSize)").foregroundColor(Color.white).bold()
                                        .font(.system(size: 25))
                                    
                                }.padding(.top,30)
                                VStack {
                                    
                                    Image("plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            if fontSize < 60 {
                                                fontSize += 1
                                            }
                                        }
                                }
                                .padding(.top,30)
                                .onChange(of: fontSize) { _, _ in
                                    guard fontSize != viewModel.favAppWidgetConfig.fontSize else { return }
                                    
                                    viewModel.favAppWidgetConfig.fontSize = fontSize
                                    isDoneButtonDisabled = false
                                }
                            }
                            
                            Spacer()
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        
                        
                        // MARK: - Number of apps in Widget
                        VStack(spacing:0) {
                            HStack(alignment: .top) {
                                Text("App / Widget")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20))
                                    .padding(.leading)
                                    .bold()
                                
                                Spacer()
                            }.padding(.top,15)
                            
                            HStack(alignment: .top,spacing: 20) {
                                VStack {
                                    Image("minus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            if widget > 1 {
                                                widget -= 1
                                            }
                                        }
                                }.padding(.top,30)
                                VStack {
                                    
                                    Text("\(widget)").foregroundColor(Color.white).bold()
                                        .font(.system(size: 25))
                                    
                                }.padding(.top,30)
                                VStack {
                                    
                                    Image("plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .onTapGesture {
                                            if widget < 6 {
                                                widget += 1
                                            }
                                        }
                                }
                                .padding(.top,30)
                                .onChange(of: widget) { _, _ in
                                    guard widget != viewModel.favAppWidgetConfig.maxNumberOfApps else { return }
                                    
                                    viewModel.favAppWidgetConfig.maxNumberOfApps = widget
                                    isDoneButtonDisabled = false
                                }
                            }
                            
                            Spacer()
                        }
                        .frame(width: widthToSet, height: widthToSet)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                    }
                    
                    
                    // MARK: - Fifth Row
                    HStack(spacing:gap) {
                        
                        
                        // MARK: - Reset Value
                        HStack {
                            Text("Reset Value")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .padding(.leading)
                                .bold()
                            
                            Spacer()
                            
                            Image("arrow")
                                .padding(.trailing)
                        }
                        .frame(width: widthToSet * 2 + gap)
                        .padding(.vertical)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 98/255, green: 97/255, blue: 104/255), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        .onTapGesture {
                            viewModel.favAppWidgetConfig = viewModel.resetConfig
                            widgetBackground = viewModel.favAppWidgetConfig.backgroundColor
                            fontColor = Color(hex: viewModel.favAppWidgetConfig.fontColor)
                            fontType = viewModel.favAppWidgetConfig.fontType
                            alignment = viewModel.favAppWidgetConfig.alignment
                            space = viewModel.favAppWidgetConfig.spacing
                            fontSize = viewModel.favAppWidgetConfig.fontSize
                            widget = viewModel.favAppWidgetConfig.maxNumberOfApps
                            
                            isDoneButtonDisabled = false
                        }
                    }
                    .padding(.bottom)
                }
            }
            .frame(height: screenHeight - 250)
            
            
            // MARK: - Done Button
            HStack {
                Text("Done")
                    .padding(.vertical, 5)
                    .padding(.horizontal, screenWidth / 3)
                    .background(isDoneButtonDisabled ? .gray : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical, 3)
                    .foregroundColor(.black)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        guard isDoneButtonDisabled == false else { return }
                        
                        viewModel.setNewFavWidgetConfig()
                        dismiss()
                    }
            }
        }
        .background(Color.black)
        .onAppear {
            gap = 20.0
            widthToSet = (screenWidth - 3 * gap) / 2.0
            bottomGap = (screenHeight - 3 * widthToSet - 4*gap - 70) / 3.0
            gapNeedToGive = (screenWidth - 3*30)/3
        }
    }
}

private extension CustomWidget {
    func isSelected(value1: String, value2: String) -> Color {
        value1 == value2 ? .blue : .clear
    }
}

#Preview {
    CustomWidget()
}
