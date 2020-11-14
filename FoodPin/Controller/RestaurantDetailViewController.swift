//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/13/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantTypeLabel: UILabel!
    @IBOutlet var restaurantLocationLabel: UILabel!
    
    // Create a new Restaurant object
    var restaurant = Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantTypeLabel.text = restaurant.type
        restaurantNameLabel.text = restaurant.name
        restaurantLocationLabel.text = restaurant.location
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
