//
//  Header.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Spacer()
            
            HStack {
                Image("little-lemon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                Text("LITTLE LEMON")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.littlePrimary)
            }
            .padding(.horizontal)
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.horizontal)
                .foregroundColor(Color.littlePrimaryAlt)
        }
        .padding(.vertical)
        .background(Color.littleWhite)
        
    }
}

#Preview {
    Header()
}
