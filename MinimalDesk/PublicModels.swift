//
//  PublicModels.swift
//  MinimalDesk
//
//  Created by Ajijul Hakim Riad on 25/11/24.
//

import Foundation
import AVKit

public enum UserDefaultsKeys: String {
    case initallySelectedFavApps
    case numberOfFavAppList
    case currentAppIcon
    case onboardingCompleted
}

let wallpaperInstructions: [String] = [
    "Watch The Video",
    "Save The Below Wallpaper To Your Photo Library",
    "Open Settings app -> Wallpaper",
    "Tap Add New Wallpaper",
    "Tap To Photos Option",
    "Tap To All Then Select The Saved Wallpaper",
    "Tap to Add Button",
    "Now Tap To Customize Home Screen",
    "Select Blur Option"
    // "Enjoy Your New Wallpaper"
]

let widgetInstructions: [String] = [
    "Watch The Video",
    "Long Press Home Screen And Select Edit",
    "Select Add Widget Option",
    "Tap On This App's Icon",
    "Tap Add Widget"
]

let darkModeInstructions: [String] = [
    "Watch The Video",
    "Open Settings And Select Display & Brightness",
    "Select Dark And Uncheck Automatic"
]

let minimalistInstructions: [String] = [ // TODO: use actual instructions
    "Watch The Video",
    "Long Press Home Screen",
    "Select The Right Window",
    "Select The Right Window",
    "Select DateTime Widget And Then Tap Add Widget",
    "Position Widgets Currectly"
]

let animationInstructions: [String] = [
    "Watch The Video",
    "Go To Settings And Tap Accessibility",
    "Tap On Per-App Settings",
    "Select Add App Option",
    "Tap On Home Screen & App Library",
    "Select Reduce Motion And Modify"
]

public enum PlanType: String {
    case monthly = "com.sadiqul.MinimalDesk.Monthly"
    case yearly = "com.sadiqul.MinimalDesk.Yearly"
    case lifetime = "com.sadiqul.MinimalDesk.Lifetime"
}

public enum SettingsOptions: String {
    case email = "Email"
    case review = "Give us a 5-star review"
    case share = "Share to Friends"
    case faq = "Frequently Asked Questions"
    case downloadText = "Download Less Phone on the App Store"
}

public enum TutorialType: String, Identifiable {
    case wallpaper
    case widget
    case customApps
    case shortcut
    case minimalist
    case reduceAnimation
    case darkMode
    
    public var id: String { self.rawValue }
    
    var lowerGuideText: String {
        switch self {
        case .wallpaper:
            return "Add the wallpaper"
        case .widget:
            return "Add the widget"
        case .customApps:
            return "Add custom apps"
        case .shortcut:
            return "Add shortcut"
        case .minimalist:
            return "Add minimal screen"
        case .reduceAnimation:
            return "Home Screen Animation"
        case .darkMode:
            return "Apply dark mode"
        }
    }
    
    var lowerGuideSubText: String {
        switch self {
        case .wallpaper:
            return "Replace your wallpaper with the new one"
        case .widget:
            return "Replace your widget with the new one"
        case .customApps:
            return "Configure your phone with custom apps"
        case .shortcut:
            return "Configure your phone with new shortcuts"
        case .minimalist:
            return "Configure your home screen with new screen"
        case .reduceAnimation:
            return "Configure your with less home screen animation"
        case .darkMode:
            return "Configure your phone with dark theme"
        }
    }
    
    var numberOfCards: Int {
        switch self {
        case .wallpaper:
            return 9
        case .widget:
            return 5
        case .customApps:
            return 5 //todo
        case .shortcut:
            return 15 //todo
        case .minimalist:
            return 6
        case .reduceAnimation:
            return 6
        case .darkMode:
            return 3
        }
    }
    
    var imageName: String {
        switch self {
        case .wallpaper:
            return "wallpaper0"
        case .widget:
            return "widget0"
        case .customApps:
            return "" //todo
        case .shortcut:
            return "" //todo
        case .minimalist:
            return "minimalist0"
        case .reduceAnimation:
            return "animation0"
        case .darkMode:
            return "darkMode0"
        }
    }
    
    var videoName: String {
        switch self {
        case .wallpaper:
            return "wallpaperSetupGuideVideo"
        case .widget:
            return "widgetSetupGuideVideo"
        case .customApps:
            return "" //todo
        case .shortcut:
            return "" //todo
        case .minimalist:
            return "minimalScreenSetupGuide"
        case .reduceAnimation:
            return "animationSetupGuideVideo"
        case .darkMode:
            return "darkModeSetupGuide"
        }
    }
    
    var videoType: String {
        switch self {
        case .wallpaper:
            return "mp4"
        case .widget:
            return "mov"
        case .customApps:
            return "" //todo
        case .shortcut:
            return "" //todo
        case .minimalist:
            return "mp4"
        case .reduceAnimation:
            return "mov"
        case .darkMode:
            return "mp4"
        }
    }
    
    var thumbnail: String {
        switch self {
        case .wallpaper:
            return "thumbnailWallpaper"
        case .widget:
            return "thumbnailWidget"
        case .customApps:
            return "" //todo
        case .shortcut:
            return "" //todo
        case .minimalist:
            return "thumbnailMinimalScreen"
        case .reduceAnimation:
            return "thumbnailAnimation"
        case .darkMode:
            return "thumbnailDarkMode 1"
        }
    }
    
    var typeNumber: String {
        switch self {
        case .wallpaper:
            return "1"
        case .widget:
            return "2"
        case .customApps:
            return "" //todo
        case .shortcut:
            return "" //todo
        case .minimalist:
            return "4"
        case .reduceAnimation:
            return "5"
        case .darkMode:
            return "3"
        }
    }
    
    var instructions: [String] {
        switch self {
        case .wallpaper:
            return wallpaperInstructions
        case .widget:
            return widgetInstructions
        case .customApps:
            return [] //todo
        case .shortcut:
            return [] //todo
        case .minimalist:
            return minimalistInstructions
        case .reduceAnimation:
            return animationInstructions
        case .darkMode:
            return darkModeInstructions
        }
    }
}

enum MediaContent: Identifiable {
    case video(player: AVPlayer)
    case image(name: String)
    
    var id: UUID { UUID() }
}
