//
//  RestaurantTableTableViewController.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/12/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit

class RestaurantTableTableViewController: UITableViewController {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei","teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    // Here a have initialized an array of 21 booleans to false which stores true or false if
    // a certain restaurant is checked. This is another way of initializing an array of the same values.
    var restaurantIsVisited = Array(repeating: false, count: 21)

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    
    // Telling the table view we only want one section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // The section will contain all the names in the restaurant array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    // Method for handling the information for each row
    // on line 43 we used "as!" to convert the generic cell to the custom cell created in RestaurantTableViewCell. ->
    // This action is called downcasting
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        
        // Here we check if the value of the restaurant being visted is true or false
        // If it is true, we set the accessory type of the cell to have a check mark
        // If not, then we set it to none.
        // This fixes the bug when reusing cells and not updating the accessory type
        if restaurantIsVisited[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    // Method to handle when you select an option
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }
        
        // Add actions to the menu
        
        // The handler in nil on the cancelAction because we have no action needed after the user presses cancel
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        
        // This block of code is refered to as a "Closure" in swift (page 277 for reference)
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            
        }
        
        // The handler means we have a follow up action after the user presses "call"
        let callAction = UIAlertAction(title: "Call " + "210-345-\(indexPath.row)", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        // Here we create another alert action for checking in when a user presses on a restaurant
        let checkInTitle = self.restaurantIsVisited[indexPath.row] ? "Undo Check in" : "Check in"
        let checkInAction = UIAlertAction(title: checkInTitle, style: .default, handler: {
            
            // Another closure line 91 - 95. This way of coding is preferred because it is more readable
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .none : .checkmark
            
            // When a certain restaurant is checked we want to update the array
            self.restaurantIsVisited[indexPath.row] = true
        })
        optionMenu.addAction(checkInAction)
        
        // Display menu
        present(optionMenu, animated: true, completion: nil)
        
        // Deselect the row aka get rid of the grey selection when you press a row
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
