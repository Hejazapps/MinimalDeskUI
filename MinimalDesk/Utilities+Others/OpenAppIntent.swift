//
//  OpenAppIntent.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 4/8/24.
//

import AppIntents
import Foundation
import UIKit

struct OpenAppIntent: AppIntent {
    static var title = LocalizedStringResource("Open a favorite app")
    static var openAppWhenRun = true
    
    @Parameter(title: "UrlString")
    var urlStr: String
    
    init(urlStr: String) {
        self.urlStr = urlStr
    }
    
    init() {
        urlStr = ""
    }
    
    func perform() async throws -> some IntentResult {
        log("urlStr = \(urlStr)")
        
        let userDefault = UserDefaults(suiteName: "group.minimaldesk") ?? UserDefaults()
        userDefault.set(urlStr, forKey: "selected-fav-app")
        
        return .result()
    }
}
