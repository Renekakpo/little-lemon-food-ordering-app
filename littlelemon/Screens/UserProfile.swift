//
//  UserProfile.swift
//  littlelemon
//
//  Created by RightMac-Rene on 08/01/2024.
//

import SwiftUI

struct UserProfile: View {
    
    @State private var userData = UserData()
    
    @State private var userDataOrigin = UserData()
    
    @State private var isPhoneNumberValid: Bool = true
    
    @State private var profileImage: Image? = nil
    
    @State private var imagePickerPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    
    private var userDataKey: String = "user_data_key"
    
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
                    let profilePlaceholder = "\(String(userData.firstName.prefix(1)))\(String(userData.lastName.prefix(1)))"
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
                        .sheet(isPresented: $imagePickerPresented) {
                            ImagePicker(image: self.$profileImage, presentationMode: presentationMode)
                        }
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
                TextField("First name", text: $userData.firstName)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                TextField("First name", text: $userData.lastName)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                TextField("Email", text: $userData.email)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                TextField("Phone number", text: $userData.phoneNumber)
                    .padding(.horizontal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .onChange(of: userData.phoneNumber) { newValue in
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
                
                Toggle("Order statuses", isOn: $userData.emailNotifications.isOrderStatusesChecked)
                Toggle("Password changes", isOn: $userData.emailNotifications.isPasswordChangesChecked)
                Toggle("Special offers", isOn: $userData.emailNotifications.isSpecialOffersChecked)
                Toggle("Newsletter", isOn: $userData.emailNotifications.isNewsletterChecked)
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
            .onAppear {
                loadUserData()
                
                // Load user's profile image
                if let imageData = userData.profileImageData,
                   let uiImage = UIImage(data: imageData) {
                    profileImage = Image(uiImage: uiImage)
                }
                
                // Make a copy of userData for discarding changes
                userDataOrigin = userData
            }
            
            // Spacer
            Spacer()
        }
        .background(Color.littleWhite)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    // Function to load user data from UserDefaults
    private func loadUserData() {
        if let userDataData = UserDefaults.standard.data(forKey: userDataKey),
           let savedUserData = try? JSONDecoder().decode(UserData.self, from: userDataData) {
            // Update the local userData
            self.userData = savedUserData
        }
    }
    
    private func handleLogoutButtonPress() {
        // Clear userData in UserDefaults
        UserDefaults.standard.removeObject(forKey: userDataKey)
        // Navigate back to the Onboarding view
        presentationMode.wrappedValue.dismiss()
    }
    
    private func handleDiscardChangesBtnPress() {
        // Reset current userData to originalUserData
        userData = userDataOrigin
    }
    
    private func handleSaveChangesButtonPress() {
        // Convert Image to Data and save it in userData
        if profileImage != nil {
            if let uiImage = uiImageFromImage(profileImage!),
               let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                userData.profileImageData = imageData
            }
        }
        
        // Save current userData to UserDefaults
        if let userDataData = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(userDataData, forKey: userDataKey)
            userDataOrigin = userData
        }
    }
    
    private func handleChangeButtonPress() {
        imagePickerPresented = true
    }
    
    private func handleRemoveButtonPress() {
        profileImage = nil
    }
}

#Preview {
    UserProfile()
}
