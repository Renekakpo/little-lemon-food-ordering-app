//
//  DishDetail.swift
//  littlelemon
//
//  Created by RightMac-Rene on 08/01/2024.
//

import SwiftUI

struct DishDetail: View {
    let dish: Dish
    
    var body: some View {
        VStack {
            Text("Details for \(dish.title ?? "")")
                .font(.title)
            
            // Display other details or information about the dish as needed
        }
        .padding()
    }
}

#Preview {
    DishDetail(dish: Dish())
}
