//
//  DishList.swift
//  littlelemon
//
//  Created by RightMac-Rene on 10/01/2024.
//

import SwiftUI

struct DishList: View {
    var dishList: [Dish]
    
    var body: some View {
        // Use the fetched dishes in the List
        List(dishList, id: \.self) { item in
            NavigationLink {
                DishDetail(dish: item) // Destination view
            } label: {
                // Display each dish in a row
                DishItemCell(dish: item)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

//#Preview {
//    let dish = Dish()
//    dish.title = ""
//    let fakeDishes = [dish]
//    return DishList(dishList: fakeDishes)
//}
