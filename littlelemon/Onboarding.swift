//
//  Onboarding.swift
//  littlelemon
//
//  Created by RightMac-Rene on 08/01/2024.
//

import SwiftUI

struct Onboarding: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    @State private var kFirstName = "first_name_key"
    @State private var kLastName = "last_name_key"
    @State private var kEmail = "email_key"
    
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                HeroBanner()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("First Name*")
                        .font(.headline)
                        .foregroundColor(Color.littleDark)
                    
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Last Name*")
                        .font(.headline)
                        .foregroundColor(Color.littleDark)
                    
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email*")
                        .font(.headline)
                        .foregroundColor(Color.littleDark)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                NavigationLink(isActive: $isLoggedIn) {
                    Home()
                } label: {
                    EmptyView()
                }
                
                Button("Register") {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        // Store the values in UserDefaults
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        
                        isLoggedIn = true
                    }
                }
                .frame(width: 200, height: 20)
                .padding()
                .background(Color.littlePrimary)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
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
