//
//  Restaurant.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/14/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import Foundation

// Defined Restaurant class with five properties (you can either set a default value
// or explicitly specify the type for each property) we did the second one
class Restaurant {
    var name: String
    var type: String
    var location: String
    var phone: String
    var description: String
    var image: String
    var isVisited: Bool
    var rating: String
    
    // Created a designated initializer that takes 5 input parameters when creating a new instance
    // Self is used to refer to the property of the class
    init(name: String, type: String, location: String, phone: String, description: String, image: String, isVisited: Bool, rating: String = "") {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.description = description
        self.image = image
        self.isVisited = isVisited
        self.rating = rating
    }
    
    // Created an optional convenience initializer
    // Without convenience initializer -> Restaurant(name: "", type: "", location: "", image: "", isVisited: false) = was to initalize an object
    // With convenience initializer -> Restaurant() = was to initalize an object
    // This saves time from typing all the initialization parameters when initializing an empty Restaurant object.
    convenience init() {
        self.init(name: "", type: "", location: "", phone: "", description: "", image: "", isVisited: false)
    }
}

