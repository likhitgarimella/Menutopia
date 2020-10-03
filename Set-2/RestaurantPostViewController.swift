//
//  RestaurantPostViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 03/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class RestaurantPostViewController: UIViewController {
    
    // Outlets
    @IBOutlet var mealName: UITextField!
    
    func Properties() {
        
        mealName.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        
    }
    
    func CornerRadius() {
        
        mealName.layer.cornerRadius = 20
        
    }
    
    func LeftPadding() {
        
        mealName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: mealName.frame.height))
        mealName.leftViewMode = .always
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        Properties()
        CornerRadius()
        LeftPadding()
        
    }
    
}   // #47
