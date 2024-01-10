//
//  UserData.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import Foundation

struct UserData: Codable {
    var profileImageData: Data? = nil
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var isLoggedIn: Bool = false
    var emailNotifications: EmailNotificationsSettings = EmailNotificationsSettings()
}
