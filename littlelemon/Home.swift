//
//  Home.swift
//  littlelemon
//
//  Created by RightMac-Rene on 08/01/2024.
//

import SwiftUI

struct Home: View {
    // Declare a new persistence constant
    let persistence = PersistenceController.shared
    
    @State private var selectedCategories: [String] = []
    
    var body: some View {
        VStack(spacing: 16) {
            HeroBanner()
            
            Text("Order for delivery!")
                .font(.headline)
                .fontWeight(.bold)
                .textCase(.uppercase)
                .padding(.top, 8)
            
//            CategoryList(categories: categories.sorted(), selectedCategories: $selectedCategories)
            
            Divider().background(Color.gray)
            
            
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    Home()
}
