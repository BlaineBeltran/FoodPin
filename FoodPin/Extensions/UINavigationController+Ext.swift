//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/16/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit

// Used to change the color of the navigation bar to light
// Override the value for childForStatusBarStyle to the top view controller
extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
