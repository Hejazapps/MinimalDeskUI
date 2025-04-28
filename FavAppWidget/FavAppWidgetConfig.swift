//
//  FavAppWidgetConfig.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 25/9/24.
//

import Foundation
import SwiftUI

struct FavAppWidgetConfig: Codable {
    var fontType: String
    var fontSize: Int
    var fontColor: String
    var backgroundColor: String
    var alignment: String
    var spacing: CGFloat
    var maxNumberOfApps: Int
    
    static var defaultConfig: FavAppWidgetConfig = .init(
        fontType: "Impact",
        fontSize: 30,
        fontColor: "#FFFFFF",
        backgroundColor: "#212121",
        alignment: "left",
        spacing: 16,
        maxNumberOfApps: 5
    )
}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = String(cleanHexCode.replacingOccurrences(of: "#", with: "").prefix(6))
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    func toHex() -> String? {
            let uic = UIColor(self)
            guard let components = uic.cgColor.components, components.count >= 3 else {
                return nil
            }
            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
            
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
}
