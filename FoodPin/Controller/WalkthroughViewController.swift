//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/19/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {
    
    // Stores reference to the walkthroughPageViewController object. This will be used later
    // to find out the current index of the walkthrogh screen
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var skipButton: UIButton!
    
    // Method to dismiss the walkthrough screen when the skip button is tapped
    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
    }
    
    // Method for when the next button is tapped. For the first two pages we call the forwardPage method
    // For the last walkthrough page we call the dismiss method to get rid of the view controller. We also
    // set a boolean key true when the user taps get started so we know not to show the walkthrough screens again
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
                
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                
                dismiss(animated: true, completion: nil)
                
            default: break
            }
        }
        
        updateUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // This method handles two things. First it controls the title of the next button and determines whether the skip button
    // is hidden. Secondly, it chnages the indicator of the page control by setting the currentPage property.
    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
                
            case 2:
                nextButton.setTitle("GET STARTED", for: .normal)
                skipButton.isHidden = true
                
            default: break
            }
            
            pageControl.currentPage = index
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }

}
