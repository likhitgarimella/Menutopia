//
//  ExploreViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 13/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    /// Logout functionality
    @IBAction func logoutAction(_ sender: UIButton) {
        
        /// using AuthService class
        AuthService.logout(onSuccess: {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.present(vc, animated: true, completion: nil)
        }, onError: {
            (errorMessage) in
            /// implement hud here
            print(errorMessage)
        })
        
    }
    
}   // #37
