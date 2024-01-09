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
    
    var body: some View {
        VStack {
            // Use the fetched dishes in the List
            List(dishes.filter { dish in
                buildPredicate()?.evaluate(with: dish) ?? true
            }, id: \.self) { dish in
                NavigationLink {
                    DishDetail(dish: dish) // Destination view
                } label: {
                    // Display each dish in a row
                    HStack {
                        // Display the image using AsyncImage
                        AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            @unknown default:
                                fatalError("Unhandled AsyncImage phase")
                            }
                        }
                    }
                    
                    // Display the title and price
                    Text("\(dish.title ?? "") - \(dish.price ?? "")")
                }
            }
        }.onAppear {
            getMenuData()
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
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    
    // Create a method to fetch menu data from the server
    func getMenuData() {
        // Clear the database before saving new data
        clearDatabase()
        
        // Define the server URL
        let serverURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        // Initialize the URL object
        guard let url = URL(string: serverURLString) else {
            print("Invalid URL")
            return
        }
        
        // Create URLRequest
        let request = URLRequest(url: url)
        
        // Use URLSession to fetch data
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the response
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // Decode the data
            if let decodedMenuList = try? JSONDecoder().decode(MenuList.self, from: data) {
                let menuItems = decodedMenuList.menu
                
                // Iterate over each menu item
                for menuItem in menuItems {
                    // Initialize a new Dish instance
                    let dish = Dish(context: viewContext)
                    
                    // Set the properties from the menu item
                    dish.title = menuItem.title
                    dish.image = menuItem.image
                    dish.price = menuItem.price
                }
                
                // Save the data into the database
                do {
                    try viewContext.save()
                } catch {
                    print("Error saving menu data: \(error.localizedDescription)")
                }
            } else {
                print("Error decoding JSON")
            }
        }
        .resume()  // Start the data task
    }
    
    // Clear the Core Data database for the Dish entity
    func clearDatabase() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
            
            do {
                let fetchedObjects = try viewContext.fetch(fetchRequest) as! [NSManagedObject]
                
                for object in fetchedObjects {
                    viewContext.delete(object)
                }
                
                try viewContext.save()
            } catch {
                print("Error clearing database: \(error.localizedDescription)")
            }
    }
}

#Preview {
    Menu()
}
