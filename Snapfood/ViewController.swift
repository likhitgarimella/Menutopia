//
//  ViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 05/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    
    func Properties() {
        
        continueButton.layer.cornerRadius = 20
        loginButton.layer.cornerRadius = 20
        signupButton.layer.cornerRadius = 20
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Properties()
        
    }
    
}   // #34
