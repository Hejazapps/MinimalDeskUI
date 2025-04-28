//
//  CustomAppView.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 23/9/24.
//

import SwiftUI

struct CustomAppView: View {
    enum DeepLinkType {
        case urlScheme
        case shortcut
    }
    @Environment(\.dismiss) var dismiss
    @State var appName: String = ""
    @State var scheme: String = ""
    @State var shortcut: String = ""
    @State var deepLinkType: DeepLinkType = .urlScheme
    
    private var placeHolderUrlScheme: String {
        guard scheme.isEmpty else { return scheme }
        guard appName.isEmpty else { return "\(appName.lowercased())://" }
        
        return "URL Scheme"
    }
    
    private var placeHolderShortcut: String {
        guard shortcut.isEmpty else { return shortcut }
        guard appName.isEmpty else { return appName }
        
        return "Shortcut"
    }
    
    private var appLink: String {
        if deepLinkType == .urlScheme {
            return scheme.isEmpty ? placeHolderUrlScheme : scheme
        } else {
            let shortcutName = (shortcut.isEmpty ? appName : shortcut).replacingOccurrences(of: " ", with: "%20")
            return "shortcuts://run-shortcut?name=\(shortcutName)"
        }
    }
    
    private var appRank: Int { -1 * viewModel.customAppList.count - 1 }
    
    
    private var viewModel: FirebaseDataViewModel
    
    init(viewModel: FirebaseDataViewModel = .shared) {
        self.viewModel = viewModel
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color(rgbRed: 0x2f, green: 0x32, blue: 0x3c))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        VStack {
            // MARK: - HEADER
            HStack {
                Text("Cancel")
                    .font(Font.custom("Inter", size: 18))
                    .foregroundStyle(Color(rgbRed: 0x8a, green: 0xc4, blue: 0x4b))
                    .onTapGesture { dismiss() }
                
                Spacer()
                
                Text("Add Custom")
                    .font(Font.custom("Inter", size: 20))
                
                Spacer()
                
                Text("Add")
                    .font(Font.custom("Inter", size: 18))
                    .foregroundStyle(Color(rgbRed: 0x8a, green: 0xc4, blue: 0x4b))
                    .onTapGesture {
                        viewModel.addCustomApp(Appp(appName: appName, appLink: appLink, appRank: appRank))
                        dismiss()
                    }
            }
            .padding([.horizontal, .top])
            
            
            
            // MARK: - APPNAME
            TextField(
                "",
                text: $appName,
                prompt: Text("App Name")
                    .font(Font.custom("Inter", size: 16))
                    .foregroundColor(Color(rgbRed: 137, green: 137, blue: 137))
            )
            .padding(.all, 10)
            .background(
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color(rgbRed: 28, green: 28, blue: 28))
            )
            .foregroundColor(.white)
            .padding([.top, .horizontal])
            
            
            
            // MARK: - PICKER
            Picker("", selection: $deepLinkType) {
                Text("URL Scheme")
                    .font(Font.custom("Inter", size: 14))
                    .tag(DeepLinkType.urlScheme)
                
                Text("Shortcuts")
                    .font(Font.custom("Inter", size: 14))
                    .tag(DeepLinkType.shortcut)
            }
            .pickerStyle(.segmented)
            .clipShape(RoundedRectangle(cornerRadius: 9))
            .padding()
            
            
            
            // MARK: - DEEPLINK
            VStack(alignment: .leading) {
                
                if deepLinkType == .urlScheme {
                    // MARK: - URL Scheme
                    TextField(
                        "",
                        text: $scheme,
                        prompt: Text(placeHolderUrlScheme)
                            .foregroundColor(Color(rgbRed: 137, green: 137, blue: 137))
                    )
                    .font(Font.custom("Inter", size: 16))
                    .padding([.horizontal, .top])
                    .padding(.bottom, 5)
                    
                }
                
                else {
                    
                    // MARK: - Shortcut
                    TextField(
                        "",
                        text: $shortcut,
                        prompt: Text(placeHolderShortcut)
                            .foregroundColor(Color(rgbRed: 137, green: 137, blue: 137))
                    )
                    .font(Font.custom("Inter", size: 16))
                    .padding([.horizontal, .top])
                    .padding(.bottom, 5)
                }
                
                Divider()
                    .background(Color(rgbRed: 0x2f, green: 0x32, blue: 0x3c))
                
                Text("Test: Open \(appName)")
                    .font(Font.custom("Inter", size: 16))
                    .foregroundStyle(Color(rgbRed: 0x8a, green: 0xc4, blue: 0x4b))
                    .padding([.horizontal, .bottom])
                    .padding(.top, 5)
                    .onTapGesture {
                        testCustomApp()
                    }
            }
            .background(Color(rgbRed: 28, green: 28, blue: 28))
            .clipShape(RoundedRectangle(cornerRadius: 9))
            .padding(.horizontal)
            
            
            // MARK: - DEEPLINK
            VStack(alignment: .leading) {
                if deepLinkType == .urlScheme {
                    // MARK: - URL Scheme
                    Text("URL Schemes, like 'Camera://' often follow a structured format that includes the target application's identifier.")
                        .padding([.top, .leading, .bottom])
                        .lineLimit(nil)  // Allow multi-line text
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Divider()
                        .background(Color(rgbRed: 0x2f, green: 0x32, blue: 0x3c))
                    
                    Text("As an alternative to finding the URL Scheme, create an \"Open App\" Shortcut in the Shortcuts app.")
                        .padding([.horizontal, .bottom])
                        .lineLimit(nil)  // Allow multi-line text
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("Create New Shortcut")
                        .font(Font.custom("Inter", size: 16))
                        .foregroundStyle(Color(rgbRed: 0x8a, green: 0xc4, blue: 0x4b))
                        .padding([.horizontal, .bottom])
                        .padding(.top, 5)
                        .lineLimit(nil)  // Allow multi-line text
                }
            }
            .background(Color(rgbRed: 28, green: 28, blue: 28))
            .clipShape(RoundedRectangle(cornerRadius: 9))
            .padding(.horizontal)
            .padding(.top)
            .frame(maxWidth: .infinity)  // Make sure the VStack stretches horizontally
            
            
            
            // MARK: - Custom AppList
            ScrollView {
                VStack {
                    ForEach(0..<viewModel.customAppList.count, id: \.self) { index in
                        HStack {
                            Text(viewModel.customAppList[index].appName)
                                .font(Font.custom("Roboto", size: 18))
                            
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.top, index == 0 ? 10 : 0)
                        .padding(.bottom, index == viewModel.customAppList.count - 1 ? 10 : 0)
                        
                        if viewModel.customAppList.count - 1 > index {
                            Divider()
                                .background(Color(rgbRed: 0x2f, green: 0x32, blue: 0x3c))
                        }
                    }
                }
                .background(Color(rgbRed: 28, green: 28, blue: 28))
                .clipShape(RoundedRectangle(cornerRadius: 9))
                .padding()
            }
            
            Spacer()
        }
        .background(.black)
        .foregroundStyle(.white)
    }
}

// MARK: - Helper Methods
private extension CustomAppView {
    func testCustomApp() {
        let application = UIApplication.shared
        
        guard let url = URL(string: appLink) else {
            log("Invalid url.")
            return
        }
        
        application.open(url, options: [:]) { (success) in
            if success {
                log("\(appLink) successfully launched.")
            } else {
                log("\(appLink) failed to launch.")
            }
        }
    }
}

#Preview {
    CustomAppView()
}
