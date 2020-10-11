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
        
        editProfile.layer.cornerRadius = 20
        logout.layer.cornerRadius = 20
        
    }
    
    func Condition() {
        
        if restaurantNameLabel.text != nil {
            userNameLabel.text = ""
        }
        if userNameLabel.text != nil {
            restaurantNameLabel.text = ""
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRestaurant()
        fetchUser()
        
        Properties()
        Condition()
        
    }
    
    @IBAction func address(_ sender: UIButton) {
        
        /// Alert
        let alertController = UIAlertController(title: "Enter address", message: "Include number and street name", preferredStyle: .alert)
        /// Add textfield
        alertController.addTextField(configurationHandler: common(textField:))
        
        /// Submit action
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            
        }
        /// Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            
        }
        
        /// AlertView font
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "SFProRounded-Medium", size: 18.0)!]
        let titleAttrString = NSMutableAttributedString(string: "Enter address", attributes: titleFont)
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        
        /// Adding Submit action
        alertController.addAction(submitAction)
        /// Adding Cancel action
        alertController.addAction(cancelAction)
        /// Present alert controller
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func citynstate(_ sender: UIButton) {
        
        /// Alert
        let alertController = UIAlertController(title: "Enter city & state", message: "City, State", preferredStyle: .alert)
        /// Add textfield
        alertController.addTextField(configurationHandler: common(textField:))
        
        /// Submit action
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            
        }
        /// Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            
        }
        
        /// AlertView font
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "SFProRounded-Medium", size: 18.0)!]
        let titleAttrString = NSMutableAttributedString(string: "Enter city & state", attributes: titleFont)
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        
        /// Adding Submit action
        alertController.addAction(submitAction)
        /// Adding Cancel action
        alertController.addAction(cancelAction)
        /// Present alert controller
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func phone(_ sender: UIButton) {
        
        /// Alert
        let alertController = UIAlertController(title: "Enter phone", message: "Business's phone number", preferredStyle: .alert)
        /// Add textfield
        alertController.addTextField(configurationHandler: common(textField:))
        
        /// Submit action
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            
        }
        /// Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            
        }
        
        /// AlertView font
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "SFProRounded-Medium", size: 18.0)!]
        let titleAttrString = NSMutableAttributedString(string: "Enter phone", attributes: titleFont)
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        
        /// Adding Submit action
        alertController.addAction(submitAction)
        /// Adding Cancel action
        alertController.addAction(cancelAction)
        /// Present alert controller
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func openhours(_ sender: UIButton) {
        
        /// Alert
        let alertController = UIAlertController(title: "Enter open hours", message: "Hours by day", preferredStyle: .alert)
        /// Add textfield
        alertController.addTextField(configurationHandler: common(textField:))
        
        /// Submit action
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            
        }
        /// Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            
        }
        
        /// AlertView font
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "SFProRounded-Medium", size: 18.0)!]
        let titleAttrString = NSMutableAttributedString(string: "Enter open hours", attributes: titleFont)
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        
        /// Adding Submit action
        alertController.addAction(submitAction)
        /// Adding Cancel action
        alertController.addAction(cancelAction)
        /// Present alert controller
        present(alertController, animated: true, completion: nil)
        
    }
    
    /// Textfield prop
    func common(textField: UITextField!) {
        let heightConstraint = NSLayoutConstraint(item: textField!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32)
        textField.addConstraint(heightConstraint)
        textField.minimumFontSize = 18
        textField.font = UIFont(name: "SFProRounded-Regular", size: 16.0)
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
    
}   // #234
