//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/12/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController , NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    
    // Created an array of Restaurant objects instead of having mutiple arrays for each set of information
    var restaurants: [RestaurantMO] = []
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    
    // Declare the search controller variable
    var searchController: UISearchController!
    
    // variable to store search results
    var searchResults: [RestaurantMO] = []
    
    @IBOutlet var emptyRestaurantView: UIView!
    
    // MARK: - View controller life cycle
        

    override func viewDidLoad() {
        // This allows for a large title at the top
        super.viewDidLoad()
        
        // Hide navigation bar on swipe for this controller
        navigationController?.hidesBarsOnSwipe = true
        
        //Prepare the empty view
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = true
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configure the navigation bar to be transparent by setting it to a blank UIImage -> UIImage()
        // Then we configured the Text and its color
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Quicksand", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0), NSAttributedString.Key.font: customFont]
        }
        
        // Fetch data from data store
        /*
         We first get the NSFetchRequest object from RestaurantMO and Specify the sort order using an NSSortDescriptor object.
         NSSortDescriptor lets you describe how the fetched onjects are sorted. Here we specify that the RestaurantMO objects
         should be sorted in ascending order using the name key. After creating the fetch request, we initialize
         fetchResultController and specify its delegate for monitoring  data changes. Lastly, we call the performFetch()
         method to excute the fecth request. When complete, we get the RestaurantMO Obejcts by accessing the fetchedObjects
         property
         */
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
        // Search Bar
        searchController = UISearchController(searchResultsController: nil)
        // Adds the search bar to the table header
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(red: 231, green: 76, blue: 60)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Check the user defaults key for hasViewedWalkthrouhg. The walkthrough screens will only appear
        // if the key is false
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source
    
    // Telling the table view we only want one section
    override func numberOfSections(in tableView: UITableView) -> Int {
        if restaurants.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        
        return 1
    }
    
    // The section will get the count from the restaurants array to determine how many rows to show or
    // to show the results when the search bar is active
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }
    
    // Method for handling the information for each row
    // on line 43 we used "as!" to convert the generic cell to the custom cell created in RestaurantTableViewCell. ->
    // This action is called downcasting
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Determine if we get the restaurant from the search results or the original array
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]

        // Configure the cell...
        // We go into the restaurants array and choose the correct parameter of the given object by using the dot syntax
        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        if let restaurantImage = restaurant.image {
            cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
        }
        
        // Here we check if the value of the restaurant being visted is true or false
        // If it is true, we set the accessory type of the cell to have a check mark
        // If not, then we set it to none.
        // This fixes the bug when reusing cells and not updating the accessory type
        if restaurant.isVisited {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        // The above if else can be written as
        // cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none

        return cell
    }
    
    // Method to filter search results for name and location
    func filterContent(for searchText: String) {
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            if let name = restaurant.name, let location = restaurant.location {
                let isMatch = name.localizedCaseInsensitiveContains(searchText) || location.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    
    // Update the search results to display
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view delegate
    
    // Method for swiping action to the left
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Creating a deletion action when swiping left
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            // Delete the row from the data source
            // We can delete the whole object rather than each property since we put the
            // restaurants in an array of objects
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                
                appDelegate.saveContext()
            }
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
            
        }
        
        // Creating a share action when swiping left
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
            
            let activityController: UIActivityViewController
            
            // If there is an image to be loaded pass it with the default text to the
            // UIActivityViewController. This will allow to embed the image when copy and pasting
            // in imessage. If not then just pass the defaul text
            if let restaurantImage = self.restaurants[indexPath.row].image, let imageToShare = UIImage(data: restaurantImage as Data) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            // For ipad
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        // Customize the delete button when swiping left
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        deleteAction.image = UIImage(systemName: "trash")
        
        // Customize the share button when swiping left
        shareAction.backgroundColor = UIColor(red: 254.0/255.0, green: 149.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
               
        
        
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let checkInAction = UIContextualAction(style: .normal, title: "Check-in") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            self.restaurants[indexPath.row].isVisited = self.restaurants[indexPath.row].isVisited ? false : true
            
            //If condition to set check icon when swiping
            cell.accessoryType = self.restaurants[indexPath.row].isVisited ? .checkmark : .none
            
            completionHandler(true)
        }
        
        let CheckInIcon = restaurants[indexPath.row].isVisited ? "arrow.uturn.left" : "checkmark"
        checkInAction.backgroundColor = UIColor(red: 38, green: 162, blue: 78)
        checkInAction.image = UIImage(systemName: CheckInIcon)
        
        let swipeConfifuration = UISwipeActionsConfiguration(actions: [checkInAction])
        
        return swipeConfifuration
    }
    
    // Disable the action on the search content
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    
    // MARK: - Navigation
    
    /* Here we check the segue's indentifier (name). In the code block we first retrieve the selected row by accessing tableView.indexPathForSelectedRow. The indexPath object should contain the selected cell. A segue contains both the soure and destination view controllers involved in the transition. You use segue.destination to retrieve the destination controller. This is why we have to downcast RestaurantDetailViewController by using the as! operator. Lastly, we pass th eimage name of the selected restaurant to the destination
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
                
                // Hide the nav bar but selecting a restaurant
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
    }
        
    // Method to go back when adding a restaurant
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    // This method is called when NSFetchedResultsController is about to start processing the content change
    // We are telling the table to get ready for changes by calling tableView.beginUpdates()
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    // When there is any content changed this method is called automatically
    // Here was also determine the type of operation and proceed with the following steps accordingly
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
            
        case .delete:
        if let indexPath = indexPath {
            tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        case .update:
        if let indexPath = indexPath {
            tableView.reloadRows(at: [indexPath], with: .fade)
            }
        
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [RestaurantMO]
        }
    }
    
    // Here we tell the table view that we have completed the update and to animate the change accordingly
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
