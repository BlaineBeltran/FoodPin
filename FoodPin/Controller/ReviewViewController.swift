//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/16/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    // Create a Outlet Collections variable to store multiple similar outlets
    @IBOutlet var rateButtons: [UIButton]!
    
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background image on the review controller
        backgroundImageView.image = UIImage(named: restaurant.image)
        
        // Applying the blur effect to the background image
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // Create a Transform object for the rate buttons
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        
        // Make the buttons invisible and move them off the screen
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
    }
    
    // Create fade in effect for the buttons
    override func viewWillAppear(_ animated: Bool) {
        
        // This is the first way to animate
        //UIView.animate(withDuration: 2.0) {
            
            // Remember when creating outlet collections they are stored in an array of UIButtoon
            // So we access the button as a noraml array by indexing -> [0] = first button
            // We just need to define the start and end states. iOS will handle the rest
           
//            self.rateButtons[0].alpha = 1.0
//            self.rateButtons[1].alpha = 1.0
//            self.rateButtons[2].alpha = 1.0
//            self.rateButtons[3].alpha = 1.0
//            self.rateButtons[4].alpha = 1.0
//
            
        // Second way to animate the buttons
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations:
            {
                self.rateButtons[0].alpha = 1.0
                self.rateButtons[0].transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.15, options: [], animations:
            {
                self.rateButtons[1].alpha = 1.0
                self.rateButtons[1].transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations:
            {
                self.rateButtons[2].alpha = 1.0
                self.rateButtons[2].transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.25, options: [], animations:
            {
                self.rateButtons[3].alpha = 1.0
                self.rateButtons[3].transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: 0.3, options: [], animations:
            {
                self.rateButtons[4].alpha = 1.0
                self.rateButtons[4].transform = .identity
        }, completion: nil)
        }

}
