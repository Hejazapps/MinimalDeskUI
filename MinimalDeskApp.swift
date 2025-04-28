//
//  MinimalDeskApp.swift
//  MinimalDesk
//
//  Created by Sadiqul Amin on 6/7/24.
//

import SwiftUI
import Firebase

@main
struct MinimalDeskApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage(UserDefaultsKeys.onboardingCompleted.rawValue) private var onboardingCompleted = false

    var body: some Scene {
        WindowGroup {
            if onboardingCompleted {
                RootView()
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                        openFavApp()
                    }
            } else {
                NavigationView {
                    OnboardingRoot()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
    
    private func openFavApp() {
        let userDefault = UserDefaults(suiteName: "group.minimaldesk") ?? UserDefaults()
        
        guard
            let urlStr = userDefault.value(forKey: "selected-fav-app") as? String,
            let url = URL(string: urlStr)
        else {
            log("URL string not valid or empty.")
            return
        }
        
        userDefault.removeObject(forKey: "selected-fav-app")
        
        log("Selected Fav app url = \(urlStr)")
        let application = UIApplication.shared
        
        application.open(url, options: [:]) { (success) in
            if success {
                log("\(urlStr) successfully launched.")
            } else {
                log("\(urlStr) failed to launch.")
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    private var app: UIApplication?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        FirebaseDataViewModel.shared.prepareAppList()
        
        return true
    }
}

// MARK: - Utility Functions
func log(
    _ message: Any = "",
    file: String = #file,
    function: String = #function,
    line: Int = #line
) {
    print(
        "[\((file as NSString).lastPathComponent.split(separator: ".").first ?? "File Name")] - "
        + "[\(function)] - [\(line)] # \(message)"
    )
}
