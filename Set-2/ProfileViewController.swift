//
//  ProfileViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 01/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var editProfile: UIButton!
    @IBOutlet var logout: UIButton!
    
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
        
        self.restaurantNameLabel.text = restaurant!.restaurantName
        
    }
    
    func updateView2() {
        
        self.userNameLabel.text = user!.userUsername
        
    }
    
    func Properties() {
        
        editProfile.layer.cornerRadius = 18
        logout.layer.cornerRadius = 18
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRestaurant()
        fetchUser()
        
        Properties()
        
    }
    
    /// Logout functionality
    @IBAction func logoutAct(_ sender: UIButton) {
        
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
    
}   // #94
