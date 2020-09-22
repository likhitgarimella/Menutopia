//
//  ViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 05/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
import FirebaseAuth

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
    
    // Notifies the VC that its view was added to a view hierarchy
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // if user signed in
        if Api.UserDet.CURRENT_RESTAURANT != nil {
            print("Current user: \(Auth.auth().currentUser)")
            // segue to tab bar VC
            self.performSegue(withIdentifier: "goToHomeDirect", sender: self)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Properties()
        
    }
    
}   // #48
