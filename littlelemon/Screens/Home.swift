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
    
    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            
            UserProfile()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
    }
}

#Preview {
    Home()
}
