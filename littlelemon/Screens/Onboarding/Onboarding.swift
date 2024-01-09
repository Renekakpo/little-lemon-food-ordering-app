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
    @State private var showAlert: Bool = false
    
    private var userDataKey = "user_data_key"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if userData.isLoggedIn {
                    // User is already logged in, navigate to Home screen
                    Home()
                } else {
                    if currentPage == 0 {
                        OnboardingPage(
                            title: "First Name*", placeholder: "First Name",
                            buttonText: "Next", text: $userData.firstName) {
                                if !self.userData.firstName.isEmpty {
                                    self.currentPage += 1
                                } else {
                                    self.showAlert = true
                                }
                            }
                    } else if currentPage == 1 {
                        OnboardingPage(title: "Last Name*", placeholder: "Last Name",
                                       buttonText: "Next",
                                       text: $userData.lastName) {
                            if !self.userData.lastName.isEmpty {
                                self.currentPage += 1
                            } else {
                                self.showAlert = true
                            }
                        }
                    } else {
                        OnboardingPage(title: "Email*",
                                       placeholder: "Email",
                                       buttonText: "Start", text: $userData.email) {
                            if !self.userData.email.isEmpty {
                                // Mark user as loggedIn
                                self.userData.isLoggedIn = true
                                
                                // Save the entire UserData struct in UserDefaults
                                if let userDataData = try? JSONEncoder().encode(self.userData) {
                                    UserDefaults.standard.set(userDataData, forKey: userDataKey)
                                }
                            } else {
                                self.showAlert = true
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                self.checkLoginStatus()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Required Fields"),
                    message: Text("Please fill in all the required fields."),
                    dismissButton: .default(Text("OK")) {
                        // Reset showAlert to false on dismiss
                        self.showAlert = false
                    }
                )
            }
        }
    }
    
    // Function to create the '*' label for required fields
    private func requiredLabel(isEmpty: Bool) -> some View {
        Text("*")
            .foregroundColor(isEmpty ? .red : .clear)
            .font(.system(size: 20, weight: .bold))
    }
    
    private func checkLoginStatus() {
        if let userDataData = UserDefaults.standard.data(forKey: userDataKey),
           let savedUserData = try? JSONDecoder().decode(UserData.self, from: userDataData),
           savedUserData.isLoggedIn,
           !savedUserData.firstName.isEmpty,
           !savedUserData.lastName.isEmpty,
           !savedUserData.email.isEmpty {
            // User is logged in, update the local userData
            self.userData = savedUserData
        }
    }
}

#Preview {
    Onboarding()
}
