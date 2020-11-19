//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/18/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit
protocol WalkthroughPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // use the weak keyword to prevent memory leak
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    
    var pageHeadings = ["CREATE YOUR OWN FOOD GUIDE", "SHOW YOU THE LOCATION", "DISCOVER GREAT RESTAURANTS"]
    var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    var pageSubHeadings = ["Pin your favorite restaurants and create your own food guide", "Search and locate your favorite restaurant on Maps", "Find restaurants shared by your friends and other foodies"]
    
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data source to itself
        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
        delegate = self
    }
    
    
    // Helper method for the pageViewController
    /*
     This method is designed to accept a page index parameter. first we validate that the given index is valid. Then we create a new instance of a specific story board using the storyboard ID. We are then given a generic view controller and downcast using as? the object to walkthrouhgContentViewController. After that we assign the content view controller with specific image, heading, subheading, and index
     */
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
            
        }
        
        return nil
    }
    
    
    
    
    
    
    // Here we get the current page index and decrease the index, then return the correct view controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    // Here we get the current page index and increase the index, then return the correct view controller
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    // Move to the next walkthough screen when the next button is tapped
    // When this method is called it automatically creates the next content view controller.
    // If the controller can be created, we call the built-in setViewControllers method and navigate to the next view
    // Controller
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // Handle updating the walkthouhg screen when swiping
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                currentIndex = contentViewController.index
                
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
        }
    }

}
