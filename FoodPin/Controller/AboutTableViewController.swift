//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/19/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    var sectionTitles = [NSLocalizedString("Feedback", comment: "Feedback"), NSLocalizedString("Follow Us", comment: "Follow Us")]
    
    // Store the related data in tuples, we are able to combine multiple vlaues into one value
    var sectionContent = [[(image: "store", text: NSLocalizedString("Rate us on the App Store", comment: "Rate us on the App Store") , link: "https://apple.com/ios/app-store/"), (image: "chat", text: NSLocalizedString("Tell us your feedback", comment: "Tell us your feedback"), link: "https://blainebeltran.com/index.php/contact/")], [(image: "twitter", text: NSLocalizedString("Twitter", comment: "Twitter") , link: "https://github.com/BlaineBeltran"), (image: "facebook", text: NSLocalizedString("Facebook", comment: "Facebook"), link: "https://github.com/BlaineBeltran"), (image: "instagram", text: NSLocalizedString("Instagram", comment: "Instagram"), link: "https://github.com/BlaineBeltran")]]

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
                    let safariController = SFSafariViewController(url: url)
                    present(safariController, animated: true, completion: nil)
                }
            } else if indexPath.row == 1 {
                if let url = URL(string: link) {
                    let safariController = SFSafariViewController(url: url)
                    present(safariController, animated: true, completion: nil)
                }
            }
        // Follow us section presented in the SFSafariViewController (allows for safari features)
        case 1:
            if let url = URL(string: link) {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
            
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // This method will find the link of the selected item and ppass it to the web view controller
    // by setting the targetURL property
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showWebView" {
//            if let destinationController = segue.destination as? WebViewController, let indexPath = tableView.indexPathForSelectedRow {
//                destinationController.targetURL = sectionContent[indexPath.section][indexPath.row].link
//            }
//        }
//    }


}
