//
//  Color.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let littlePrimary = Color(hex: "#495E57")
    static let littlePrimaryAlt = Color(hex: "#F4CE14")
    static let littleSecondary = Color(hex: "#EE9972")
    static let littleSecondaryAlt = Color(hex: "#FBDABB")
    static let littleLight = Color(hex: "#EDEFEE")
    static let littleGray = Color(hex: "#ccc")
    static let littleDark = Color(hex: "#333333")
    static let littleWhite = Color(hex: "#FFFFFF")
}

// Custom extension to convert hex string to SwiftUI Color
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}
