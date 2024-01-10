//
//  EmailNotificationsSettings.swift
//  littlelemon
//
//  Created by RightMac-Rene on 10/01/2024.
//

import Foundation

struct EmailNotificationsSettings: Codable {
    var isOrderStatusesChecked: Bool = false
    var isPasswordChangesChecked: Bool = false
    var isSpecialOffersChecked: Bool = false
    var isNewsletterChecked: Bool = false
}
