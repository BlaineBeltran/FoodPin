//
//  RestaurantDetailMapCell.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/16/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailMapCell: UITableViewCell {
    
    // Create an outlet for the mapkit
    @IBOutlet var mapView: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Confirgure the map
    // Added a new method called configure that accepts the restaurants address parameter
    func configure(location: String) {
        // Get location
        let geoCoder = CLGeocoder()
        
        print(location)
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                // Remember when using the geocoder it parsees through the string and returns an array of
                // placemark objects from the geocoding server asynchronously. The number of returned placemark
                // objects depends on the address you provide. The more specific the address information you have given,
                // the better the result
                
                // Get the first placemark
                let placemark = placemarks[0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    // Display the annotation
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    // Set the zoom level
                    // Use the MKCoordinareRegion function to adjust the initial
                    // zoom level of the map to 250 meter radius
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
    }

}
