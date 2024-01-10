//
//  Menu.swift
//  littlelemon
//
//  Created by RightMac-Rene on 08/01/2024.
//

import SwiftUI
import CoreData

struct Menu: View {
    // Declare the managedObjectContext variable
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch all the Dishes from Core Data using the sort descriptors and search text
    @FetchRequest(
        entity: Dish.entity(),
        sortDescriptors: buildSortDescriptors(),
        predicate: NSPredicate(value: true))
    var dishes: FetchedResults<Dish>
    
    // State variable for the search text
    @State private var searchText = ""
    
    // State variable for selected categories
    @State private var selectedCategories: [String] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Header()
                
                HeroBanner(showSearchField: true, searchText: $searchText)
                    .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    Text("Order for delivery!")
                        .font(.headline)
                        .bold()
                        .textCase(.uppercase)
                        .padding(.top, 10)
                    
                    MenuBreakDown(selectedCategories: $selectedCategories)
                }
                .padding(.horizontal, 10)
                
                let filteredDishes = dishes.filter { dish in
                    buildPredicate()?.evaluate(with: dish) ?? true &&
                    (selectedCategories.isEmpty || selectedCategories.contains(dish.category?.lowercased() ?? "")) }
                DishList(dishList: filteredDishes)
            }
            .background(Color.littleWhite)
            .onAppear {
                getMenuData(viewContext: self.viewContext) {
                    // On data loaded
                }
            }
        }
    }
    
    // Sorting by name
    static func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    // Function to build NSPredicate based on the search text
    func buildPredicate() -> NSPredicate? {
        if searchText.isEmpty {
            return nil
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText.lowercased())
        }
    }
}

//#Preview {
//    let persistenceController = PersistenceController.preview
//
//    Menu()
//        .environment(\.managedObjectContext, persistenceController.container.viewContext)
//}
