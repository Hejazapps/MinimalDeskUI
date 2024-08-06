//
//  MinimalDeskDateWidgetBundle.swift
//  MinimalDeskDateWidget
//
//  Created by Rakib Hasan on 17/7/24.
//

import WidgetKit
import SwiftUI

@main
struct MinimalDeskDateWidgetBundle: WidgetBundle {
    var body: some Widget {
        MinimalDeskDateWidget()
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
