//
//  Utils.swift
//  littlelemon
//
//  Created by RightMac-Rene on 10/01/2024.
//

import Foundation
import SwiftUI

let categories = [
    "starters",
    "mains",
    "desserts",
    "drinks",
    "spec",
    "salads",
    "appetizers",
    "side dishes",
    "cocktails",
    "snacks"
]

func formattedPrice(price: String?) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "$" // Customize currency symbol if needed
    
    if let mPrice = Double(price!) {
        return formatter.string(from: NSNumber(value: mPrice)) ?? ""
    }
    
    return ""
}

func isValidPhoneNumber(_ value: String) -> Bool {
    let phonePattern = #"^\(\d{3}\) \d{2}-\d{2}-\d{2}-\d{2}$"#
    let regex = try? NSRegularExpression(pattern: phonePattern)
    let range = NSRange(location: 0, length: value.utf16.count)
    return regex?.firstMatch(in: value, options: [], range: range) != nil
}

func uiImageFromImage(_ image: Image) -> UIImage? {
    let controller = UIHostingController(rootView: image)
    controller.view.frame = CGRect(x: 0, y: 0, width: 100, height: 100) // Set an appropriate frame
    let uiView = controller.view

    let renderer = UIGraphicsImageRenderer(size: uiView!.bounds.size)
    let uiImage = renderer.image { _ in
        uiView?.drawHierarchy(in: uiView!.bounds, afterScreenUpdates: true)
    }
    return uiImage
}
