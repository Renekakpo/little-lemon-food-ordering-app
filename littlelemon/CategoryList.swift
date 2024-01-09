//
//  CategoryList.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import SwiftUI

struct CategoryList: View {
    var categories: [String]
        @Binding var selectedCategories: [String]

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            toggleCategory(category: category)
                        }) {
                            Text(category)
                                .fontWeight(.bold)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(selectedCategories.contains(category) ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }

        private func toggleCategory(category: String) {
            if let index = selectedCategories.firstIndex(of: category) {
                selectedCategories.remove(at: index)
            } else {
                selectedCategories.append(category)
            }
        }
}
