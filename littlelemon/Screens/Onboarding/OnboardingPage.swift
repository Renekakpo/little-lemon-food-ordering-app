//
//  OnboardingPage.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import SwiftUI

struct OnboardingPage: View {
    var title: String
    var placeholder: String
    var buttonText: String
    @Binding var text: String
    var onNext: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16) {
            HeroBanner()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.littleDark)
                
                TextField(placeholder, text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button(action: {
                onNext?()
            }) {
                Text(buttonText)
                    .frame(width: 200, height: 20)
                    .padding()
                    .background(Color.littlePrimary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

//#Preview {
//    let data = UserData(firstName: "lorem", lastName: "ipsum", email: "")
//    OnboardingPage(userData: data)
//}
