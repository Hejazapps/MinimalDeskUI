//
//  FavAppWidgetBundle.swift
//  FavAppWidget
//
//  Created by Rakib Hasan on 4/8/24.
//

import WidgetKit
import SwiftUI

@main
struct FavAppWidgetBundle: WidgetBundle {
    var body: some Widget {
        FavAppWidget()
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
        "[\((file as NSString).lastPathComponent.split(separator: ".").first ?? "File Name") - "
        + "[\(function)] - [\(line)] # \(message)"
    )
}
