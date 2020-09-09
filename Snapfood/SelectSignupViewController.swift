//
//  SelectSignupViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 09/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class SelectSignupViewController: UIViewController {
    
    // Outlets
    @IBOutlet var selectRestaurant: UIButton!
    @IBOutlet var selectUser: UIButton!
    
    func CornerRadius() {
        
        selectRestaurant.layer.cornerRadius = 20
        selectUser.layer.cornerRadius = 20
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CornerRadius()
        
    }
    
}   // #32
