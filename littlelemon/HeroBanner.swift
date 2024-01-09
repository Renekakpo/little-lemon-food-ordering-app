//
//  HeroBanner.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import SwiftUI

struct HeroBanner: View {
    @State private var searchText = ""
    var showSearchField: Bool
    
    init(showSearchField: Bool = false) {
        self.showSearchField = showSearchField
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Little Lemon")
                .font(.title)
                .foregroundColor(Color.littlePrimaryAlt)
            
            
            Text("Benin")
                .font(.title2)
                .foregroundColor(Color.littleWhite)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome to our restaurant! We are a family-owned African restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.subheadline)
                        .frame(height: 120)
                        .foregroundColor(Color.littleWhite)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                }
                
                Image("home-dish")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                    .padding()
            }
            
            if showSearchField {
                SearchBar(text: $searchText)
                    .padding(.top, 16)
            }
        }
        .padding()
        .background(Color.littlePrimary)
        .cornerRadius(4)
    }
}

#Preview {
    Group {
        HeroBanner()
        HeroBanner(showSearchField: true)
    }
    .previewLayout(.sizeThatFits)
    .padding()
}
