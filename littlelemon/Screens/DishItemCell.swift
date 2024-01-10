//
//  DishItemView.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import SwiftUI

struct DishItemCell: View {
    var dish: Dish
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Display Menu Title
                Text(dish.title ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.littleDark)
                
                // Display Menu Description
                Text(dish.info ?? "")
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                
                // Display Menu Price
                Text(formattedPrice(price: dish.price))
                    .font(.headline)
                    .foregroundColor(Color.gray)
            }
        }
        
        Spacer()
        
        // Display Menu Image
        AsyncImage(url: URL(string: dish.image ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Rectangle())
                    .cornerRadius(5.0)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Rectangle())
                    .cornerRadius(5.0)
            @unknown default:
                fatalError("Unhandled AsyncImage phase")
            }
        }
    }
    
}

//#Preview {
//    DishItemCell(dish: Dish())
//}
