//
//  UserProfile.swift
//  littlelemon
//
//  Created by RightMac-Rene on 08/01/2024.
//

import SwiftUI

struct UserProfile: View {
    @State private var isOrderStatusesChecked: Bool = false
    @State private var isPasswordChangesChecked: Bool = false
    @State private var isSpecialOffersChecked: Bool = false
    @State private var isNewsletterChecked: Bool = false
    @State private var isPhoneNumberValid: Bool = true
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    
    // Add three text elements to hold user information from UserDefaults
    let udFirstName: String = UserDefaults.standard.string(forKey: "first_name_key") ?? ""
    let udLastName: String = UserDefaults.standard.string(forKey: "last_name_key") ?? ""
    let udEmail: String = UserDefaults.standard.string(forKey: "email_key") ?? ""
    
    @State private var profileImage: Image? = nil
    
    // Add a button to logout
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView {
            // Header
            Text("Personal information")
                .font(.title)
                .padding()
            
            // User profile picture section
            HStack(spacing: 30) {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                } else {
                    let profilePlaceholder = "\(String(firstName.prefix(1)))\(String(lastName.prefix(1)))"
                    // Placeholder with user initials
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.littleLight)
                        .overlay(
                            Text("\(profilePlaceholder)")
                                .font(.system(size: 24))
                                .foregroundColor(Color.littleDark)
                        )
                }
                
                // Change and Remove buttons
                Button(action: handleChangeButtonPress) {
                    Text("Change")
                        .font(.headline)
                        .foregroundColor(Color.littleWhite)
                        .padding()
                        .background(Color.littlePrimary)
                        .cornerRadius(8)
                }
                
                Button(action: handleRemoveButtonPress) {
                    Text("Remove")
                        .font(.headline)
                        .foregroundColor(Color.littleDark)
                        .padding()
                        .background(Color.littleWhite)
                        .border(Color.black, width: 2)
                        .cornerRadius(4)
                }
            }
            .padding()
            
            // Fields section
            VStack(alignment: .leading, spacing: 16) {
                TextField("First name", text: $firstName)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                TextField("First name", text: $firstName)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                TextField("Email", text: $email)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                TextField("Phone number", text: $phoneNumber)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .onChange(of: phoneNumber) { newValue in
                        // Validate phone number and update isPhoneNumberValid
                        isPhoneNumberValid = isValidPhoneNumber(newValue)
                    }
                    .foregroundColor(isPhoneNumberValid ? .black : .red)
                    .alert(isPresented: .constant(!isPhoneNumberValid)) {
                        Alert(title: Text("Invalid Phone Number"),
                              message: Text("Please use the format (000) 000-0000."),
                              dismissButton: .default(Text("OK")))
                    }
            }
            .padding(.horizontal, 15)
            
            // Checkbox section
            VStack(alignment: .leading, spacing: 10) {
                Text("Email notifications")
                    .font(.headline)
                
                Toggle("Order statuses", isOn: $isOrderStatusesChecked)
                Toggle("Password changes", isOn: $isPasswordChangesChecked)
                Toggle("Special offers", isOn: $isSpecialOffersChecked)
                Toggle("Newsletter", isOn: $isNewsletterChecked)
            }
            .padding(.top, 25)
            .padding(.horizontal, 15)
            
            // Logout button
            Button(action: handleLogoutButtonPress) {
                Text("Log out")
                    .font(.headline)
                    .foregroundColor(Color.littleDark)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.littlePrimaryAlt)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.littleSecondaryAlt, lineWidth: 2)
                    )
                    .padding(.top, 35)
                    .padding(.horizontal, 15)
            }
            
            // Footer section
            HStack(spacing: 10) {
                Button(action: handleDiscardChangesBtnPress) {
                    Text("Discard changes")
                        .font(.headline)
                        .foregroundColor(Color.littleDark)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.littleWhite)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.littlePrimary, lineWidth: 2)
                        )
                        .padding(.trailing, 10)
                }
                
                Button(action: handleSaveChangesButtonPress) {
                    Text("Save changes")
                        .font(.headline)
                        .foregroundColor(Color.littleWhite)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color.littlePrimary)
                        .cornerRadius(8)
                        .padding(.leading, 10)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 15)
            
            // Spacer
            Spacer()
        }
        .background(Color.littleWhite)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    private func handleLogoutButtonPress() {
        UserDefaults.standard.set(false, forKey: "is_logged_in_key")
        self.presentation.wrappedValue.dismiss()
    }
    
    private func handleDiscardChangesBtnPress() {
        firstName = UserDefaults.standard.string(forKey: "first_name_key") ?? ""
        lastName = UserDefaults.standard.string(forKey: "last_name_key") ?? ""
        email = UserDefaults.standard.string(forKey: "email_key") ?? ""
        phoneNumber = ""
        
        isOrderStatusesChecked = false
        isPasswordChangesChecked = false
        isSpecialOffersChecked = false
        isNewsletterChecked = false
        
        profileImage = nil
    }
    
    private func handleSaveChangesButtonPress() {
        let updatedUserData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phoneNumber": phoneNumber,
            "emailNotifications": [
                "orderStatuses": isOrderStatusesChecked,
                "passwordChanges": isPasswordChangesChecked,
                "specialOffers": isSpecialOffersChecked,
                "newsletter": isNewsletterChecked
            ],
            "profileImage": profileImage ?? ""
        ]
        
        // Save updatedUserData to UserDefaults
        UserDefaults.standard.set(updatedUserData, forKey: "userData")
    }
    
    private func handleChangeButtonPress() {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = true
//        picker.sourceType = .photoLibrary
//        picker.delegate = context.coordinator
//        parent.present(picker, animated: true, completion: nil)
    }
    
    private func handleRemoveButtonPress() {
        profileImage = nil
    }
    
    private func isValidPhoneNumber(_ value: String) -> Bool {
        let phonePattern = #"^\(\d{3}\) \d{2}-\d{2}-\d{2}-\d{2}$"#
        let regex = try? NSRegularExpression(pattern: phonePattern)
        let range = NSRange(location: 0, length: value.utf16.count)
        return regex?.firstMatch(in: value, options: [], range: range) != nil
    }
}

#Preview {
    UserProfile()
}
