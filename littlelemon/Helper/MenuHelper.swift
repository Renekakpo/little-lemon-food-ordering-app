//
//  MenuHelper.swift
//  littlelemon
//
//  Created by RightMac-Rene on 09/01/2024.
//

import Foundation
import CoreData

func getMenuData(viewContext: NSManagedObjectContext, completion: @escaping () -> Void) {
    // Clear the database before saving new data
    clearDatabase(viewContext: viewContext)

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
                dish.category = menuItem.category
                dish.info = menuItem.description
            }

            // Save the data into the database
            do {
                try viewContext.save()
                completion()
            } catch {
                print("Error saving menu data: \(error.localizedDescription)")
            }
        } else {
            print("Error decoding JSON")
        }
    }
    .resume()  // Start the data task
}

func clearDatabase(viewContext: NSManagedObjectContext) {
    PersistenceController.shared.clear()
//    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
//
//    do {
//        let fetchedObjects = try viewContext.fetch(fetchRequest) as! [NSManagedObject]
//
//        for object in fetchedObjects {
//            viewContext.delete(object)
//        }
//
//        try viewContext.save()
//    } catch {
//        print("Error clearing database: \(error.localizedDescription)")
//    }
}
