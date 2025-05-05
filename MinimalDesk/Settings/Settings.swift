
//
//  CategoryListView.swift
//  OutletExpense
//
//  Created by Mamunur Rahaman on 8/17/23.
//

import SwiftUI

struct Settings: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.requestReview) var requestReview
    
    @State private var presentSubscriptionView = false
    @State private var favoriteColor = 0
    @State private var showAppIcon = false
    @State private var appIcon = "AppIcon"
    
    private let colors = ["System", "Dark", "Light"]
    let items: [SettingsOptions] = [.downloadText, .share, .faq]
    
    private var rootViewController: UIViewController? {
        UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow })?.rootViewController
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                VStack {
                    Text("Settings").bold()
                        .foregroundColor(Color.white).font(.system(size: 25))
                }
                .padding(15)
                
                VStack(spacing: 0) {
                    ScrollView {
                        VStack(spacing: 10) {
                            // MARK: Header and Top Image
                            VStack(spacing: 0) {
                                Image("topView")
                                    .resizable()
                                    .frame(width: screenWidth * 0.9, height: getHeight())
                                    .onTapGesture {
                                        presentSubscriptionView = true
                                    }
                            }
                            
                            // MARK: - Theme Picker
                            /*
                             Text("Themes").foregroundColor(Color.white)
                             .frame(maxWidth: .infinity, alignment: .leading).padding(.leading,20)
                             
                             ZStack {
                             
                             Color(red: 25.0 / 255, green: 25.0 / 255, blue: 25.0 / 255).edgesIgnoringSafeArea(.all)
                             
                             VStack {
                             Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                             ForEach(0..<colors.count) { index in
                             Text(colors[index])
                             .tag(index)
                             }
                             }
                             .pickerStyle(SegmentedPickerStyle())
                             .foregroundColor(.white) // Default text color
                             
                             // Custom segmented control style
                             .background(
                             RoundedRectangle(cornerRadius: 8)
                             .fill(Color(red: 39.0 / 255, green: 39.0 / 255, blue: 41.0 / 255)) // Selected segment color
                             )
                             .padding(.horizontal)
                             .onAppear {
                             UISegmentedControl.appearance().selectedSegmentTintColor = .white
                             UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                             UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
                             }
                             }
                             .frame(width: screenWidth * 0.9)
                             .padding(.top,4)
                             .padding(.bottom,4)
                             }
                             .cornerRadius(20)
                             .frame(height: 37)
                             */
                            
                            // MARK: - App Icon
                            ZStack {
                                Color(red: 25.0 / 255, green: 25.0 / 255, blue: 25.0 / 255).edgesIgnoringSafeArea(.all)
                                HStack {
                                    HStack {
                                        Image(changeName(from: appIcon))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                            .cornerRadius(5)
                                            .padding(10)
                                        
                                        Text("AppIcon")
                                            .foregroundColor(Color.white).font(.system(size: 14))
                                    }
                                    .padding(.leading,15)
                                    
                                    Spacer()
                                    
                                    Image("arrow r")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.trailing,15)
                                }
                                .onAppear {
                                    appIcon = UserDefaults.standard.string(forKey: UserDefaultsKeys.currentAppIcon.rawValue) ?? "App logo 2"
                                }
                            }
                            .cornerRadius(20)
                            .frame(height: 37)
                            .padding()
                            .onTapGesture {
                                showAppIcon.toggle()
                            }
                            
                            
                            // MARK: - Support & Others
                            ZStack {
                                Color(red: 25.0 / 255, green: 25.0 / 255, blue: 25.0 / 255).edgesIgnoringSafeArea(.all)
                                VStack {
                                    VStack {
                                        Text("Support & Others")
                                            .frame(maxWidth: .infinity, alignment: .leading).padding(.leading,20)
                                            .foregroundColor(Color.white)
                                            .padding(.top,10)
                                    }
                                    
                                    ZStack {
                                        Color(red: 39.0 / 255, green: 39.0 / 255, blue: 41.0 / 255).edgesIgnoringSafeArea(.all)
                                        
                                        List(items, id: \.self) { item in
                                            HStack {
                                                Image(item.rawValue)
                                                    .frame(width: 30, height: 30)
                                                
                                                Text(item.rawValue)
                                                    .foregroundColor(Color.white)
                                                //.fixedSize(horizontal: false, vertical: true)
                                                    .font(.system(size: 14, weight: .medium))
                                                
                                                
                                                Spacer()
                                            }
                                            .padding()
                                            .background(
                                                Color(red: 39.0 / 255, green: 39.0 / 255, blue: 41.0 / 255)
                                                    .edgesIgnoringSafeArea(.all)
                                            )
                                            .listRowInsets(EdgeInsets())
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .frame(height: 50)
                                            //                                            .onTapGesture {
                                            //                                                switch item {
                                            //                                                case .share:
                                            //                                                    shareAppLink()
                                            //                                                case .faq:
                                            //                                                default:
                                            //                                                    print("Invalid options selected")
                                            //                                                    break
                                            //                                                }
                                            //
                                            //
                                            //
                                            //                                            }
                                            
                                            .onTapGesture {
                                                switch item {
                                                case .share:
                                                    shareAppLink()
                                                case .faq:
                                                    openFAQ()
                                                default:
                                                    print("Invalid options selected")
                                                }
                                            }
                                            
                                            
                                        }
                                        .listStyle(PlainListStyle())
                                    }
                                    .frame(height: 155)
                                    .cornerRadius(20)
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, 20)
                                }
                            }
                            .cornerRadius(20)
                            .padding([.horizontal, .bottom])
                            
                            ratingPopUp()
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $presentSubscriptionView) {
            SubscriptionView()
        }
        .fullScreenCover(isPresented: $showAppIcon) {
            AppIconsView(appIcon: $appIcon)
        }
    }
    
    func getHeight()->CGFloat {
        let value  = (screenWidth * 0.8 * 600)/1047
        return value
    }
    
    func openApp(urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showNoAppAlert("mail")
            }
        }
    }
    
    func showNoAppAlert(_ appName: String) {
        guard let rootViewController else {
            return
        }
        
        let alert = UIAlertController(
            title: "\(appName.capitalized) App Not Available",
            message: "No mail \(appName) is configured on this device. Please set up a \(appName) app to send emails.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        rootViewController.present(alert, animated: true, completion: nil)
    }
    
    func shareAppLink() {
        let appID = "APP_ID" // TODO: Replace with app’s ID (found in App Store Connect)
        let appStoreLink = "https://apps.apple.com/app/id\(appID)"
        let activityViewController = UIActivityViewController(activityItems: [appStoreLink], applicationActivities: nil)
        activityViewController.overrideUserInterfaceStyle = .dark
        
        if let rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    //"https://docs.google.com/document/d/11PN0_mtIvf5DWj5663SZtJAYtgANvhWPkWIX3YU2eI/edit?usp=sharing"
    func openFAQ() {
        if let url = URL(string:
                            "https://docs.google.com/document/d/11PN_0_mtIvf5DWj5663SZtJAYtgANvhWPkWIX3YU2eI/edit?tab=t.0") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    
    private func ratingPopUp() -> some View {
        ZStack {
            Image("holderBG")
                .resizable()
                .scaledToFill()
            
            VStack {
                Image("face")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(.circle)
                Image("description")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                HStack(spacing: 0) {
                    Image("contactUS")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth * 0.42, height: 60)
                        .padding(3)
                        .onTapGesture {
                            //                            openApp(urlString: "mailto:?subject=Feedback&body=Hello,")
                            
                            openApp(urlString: "mailto:assistance.minimaldesk@gmail.com?subject=Feedback%20about%20LessPhone%20app&body=Hello,")
                            
                        }
                    Image("rateApp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth * 0.42, height: 60)
                        .padding(3)
                        .onTapGesture {
                            requestReview()
                        }
                }
            }
        }
        .frame(width: screenWidth * 0.91, height: 250)
        .cornerRadius(15)
    }
    
    private func changeName(from name: String) -> String {
        guard let index = name.last else {
            return "App logo 2"
        }
        return "App logo \(index)"
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
