//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/12/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    // IBOutlet is a keyword to indicate a property of a class that can
    // be exposed to interface builder -> we call these variables outlets
    // Notice the circles next to the outlets. This indicates a connection has been made
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView! {
        
        // Here we are using a didset (property observer) to change the corner radius
        // and to clip the image to bounds, which causes the content to be clipped to the rounded corners
        didSet {
            // I have commented out the changes because I have also done the same thing on the Interface Builder.
            // Check the runtime attributes of the imageview in indentity inspector
            
            //thumbnailImageView.layer.cornerRadius = thumbnailImageView.bounds.width / 2
            //thumbnailImageView.clipsToBounds = true
        }
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
