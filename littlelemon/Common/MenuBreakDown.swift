//
//  CategoryList.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import SwiftUI

struct MenuBreakDown: View {
    @Binding var selectedCategories: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        toggleCategory(category: category)
                    }) {
                        Text(category.capitalized)
                            .fontWeight(.bold)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(selectedCategories.contains(category) ? Color.littlePrimary : Color.littleLight)
                            .foregroundColor(selectedCategories.contains(category) ? Color.littleWhite : Color.littlePrimary)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.vertical, 8)
        }
    }
    
    private func toggleCategory(category: String) {
        if let index = selectedCategories.firstIndex(of: category.lowercased()) {
            selectedCategories.remove(at: index)
        } else {
            selectedCategories.append(category.lowercased())
        }
    }
}

//#Preview {
//    MenuBreakDown(categories: categories, selectedCategories: T##Binding<[String]>)
//}
