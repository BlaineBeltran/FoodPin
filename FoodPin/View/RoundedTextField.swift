//
//  RoundedTextField.swift
//  FoodPin
//
//  Created by Blaine Beltran on 11/17/20.
//  Copyright © 2020 Blaine Beltran. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    /*
     The first three methods are for the text indentation
     
     The first method - returns the drawing rectangle for the text field
     The second method - returns the drawing rectangle for the text field's placeholder text
     The third method - returns the rectangle in which editable text can be displayed
     
     Default: These methods return a rectangle without indentation. Therefore we override these methods a return
     a rectangle with indentation. We use UIEdgeInsets to create a padding area, and then we call bounds.insets(by: padding) to apply the edge insets to shrink the rectangle
     */
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // This method is called every time when the text field is laid out
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
}
