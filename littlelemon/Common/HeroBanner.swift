//
//  HeroBanner.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import SwiftUI

struct HeroBanner: View {
    @Binding var searchText: String
    var showSearchField: Bool
    
    init(showSearchField: Bool = false, searchText: Binding<String>) {
        self.showSearchField = showSearchField
        _searchText = searchText
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Little Lemon")
                .font(.title)
                .foregroundColor(Color.littlePrimaryAlt)
            
            Text("Benin")
                .font(.title2)
                .foregroundColor(Color.littleWhite)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Welcome! We are a family-owned African restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.subheadline)
                        .frame(height: 80)
                        .foregroundColor(Color.littleWhite)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                }
                
                Spacer()
                
                Image("home-dish")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                    .padding()
            }
            
            if showSearchField {
                SearchBar(text: $searchText)
            }
        }
        .padding()
        .background(Color.littlePrimary)
        .cornerRadius(4)
    }
}

//#Preview {
//    Group {
//        HeroBanner()
//        HeroBanner(showSearchField: true)
//    }
//    .previewLayout(.sizeThatFits)
//    .padding()
//}
