//
//  ExploreViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 13/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet var restaurantEmailLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    
    var restaurant: AppUser? {
        didSet {
            updateView1()
        }
    }
    
    var user: AppUser? {
        didSet {
            updateView2()
        }
    }
    
    func fetchRestaurant() {
        
        Api.UserDet.observeCurrentRestaurant { (restaurant) in
            self.restaurant = restaurant
        }
        
    }
    
    func fetchUser() {
        
        Api.UserDet.observeCurrentUser { (user) in
            self.user = user
        }
        
    }
    
    func updateView1() {
        
        self.restaurantEmailLabel.text = restaurant!.restaurantEmail
        
    }
    
    func updateView2() {
        
        self.userEmailLabel.text = user!.userEmail
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRestaurant()
        fetchUser()
        
    }
    
    /// Logout functionality
    @IBAction func logoutAction(_ sender: UIButton) {
        
        /// using AuthService class
        AuthService.logout(onSuccess: {
            print("----------------")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.present(vc, animated: true, completion: nil)
        }, onError: {
            (errorMessage) in
            /// implement hud here
            print(errorMessage)
        })
        
    }
    
}   // #82
