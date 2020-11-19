//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/19/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
    
    var sectionTitles = ["Feedback", "Follow Us"]
    
    // Store the related data in tuples, we are able to combine multiple vlaues into one value
    var sectionContent = [[(image: "store", text: "Rate us on the App Store", link: "https://apple.com/ios/app-store/"), (image: "chat", text: "Tell us your feedback", link: "https://blainebeltran.com/index.php/contact/")], [(image: "twitter", text: "Twitter", link: "https://github.com/BlaineBeltran"), (image: "facebook", text: "Facebook", link: "https://github.com/BlaineBeltran"), (image: "instagram", text: "Instagram", link: "https://github.com/BlaineBeltran")]]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configure nav bar apperance
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Quicksand", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60), NSAttributedString.Key.font: customFont ]
        }
        
        // Used to remove the extra seperators
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionContent[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath)
        
        // Configure the cell...
        let cellData = sectionContent[indexPath.section][indexPath.row]
        cell.textLabel?.text = cellData.text
        cell.imageView?.image = UIImage(named: cellData.image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = sectionContent[indexPath.section][indexPath.row].link
        
        switch indexPath.section {
            // Leave us feedback section
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: link) {
                    UIApplication.shared.open(url)
                }
            }
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }


}
