//
//  Onboarding.swift
//  littlelemon
//
//  Created by RightMac-Rene on 08/01/2024.
//

import SwiftUI

struct Onboarding: View {
    
    @State private var userData = UserData()
    @State private var currentPage: Int = 0
    
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if currentPage == 0 {
                    OnboardingPage(
                        title: "First Name*", placeholder: "First Name",
                        buttonText: "Next", text: $userData.firstName) {
                            if !self.userData.firstName.isEmpty {
                                self.currentPage += 1
                            }
                        }
                } else if currentPage == 1 {
                    OnboardingPage(title: "Last Name*", placeholder: "Last Name",
                                   buttonText: "Next",
                                   text: $userData.lastName) {
                        if !self.userData.lastName.isEmpty {
                            self.currentPage += 1
                        }
                    }
                } else {
                    OnboardingPage(title: "Email*",
                                   placeholder: "Email",
                                   buttonText: "Start", text: $userData.email) {
                        if !self.userData.email.isEmpty {
                            // Save the entire UserData struct in UserDefaults
                            if let userDataData = try? JSONEncoder().encode(self.userData) {
                                UserDefaults.standard.set(userDataData, forKey: "user_data_key")
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // Function to create the '*' label for required fields
    private func requiredLabel(isEmpty: Bool) -> some View {
        Text("*")
            .foregroundColor(isEmpty ? .red : .clear)
            .font(.system(size: 20, weight: .bold))
    }
}

#Preview {
    Onboarding()
}
