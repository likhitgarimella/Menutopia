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
    
    @IBOutlet var profileCollectionView: UICollectionView!
    
    var posts: [MealPostModel] = []
    
    func fetchRestaurant() {
        
        /// observeCurrentRestaurant
        Api.UserDet.observeCurrentRestaurant { (restaurant) in
            self.restaurant = restaurant
            self.profileCollectionView.reloadData()
        }
        
    }
    
    func fetchUser() {
        
        /// observeCurrentUser
        Api.UserDet.observeCurrentUser { (user) in
            self.user = user
            self.profileCollectionView.reloadData()
        }
        
    }
    
    func fetchMyPosts() {
        
        guard let currentUser = Api.UserDet.CURRENT_USER else {
            return
        }
        Api.MyRestaurantPosts.REF_MYPOSTS.child(currentUser.uid).observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            Api.RestaurantPost.observePost(withId: snapshot.key, completion: {
                post in
                // print(post.id)
                self.posts.append(post)
                self.profileCollectionView.reloadData()
            })
        })
        
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
        
        // Register CollectionViewCell 'PhotoCollectionViewCell' here
        profileCollectionView.register(UINib.init(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        if let flowLayout = profileCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        fetchRestaurant()
        fetchUser()
        
        Properties()
        Condition()
        
        fetchMyPosts()
        
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
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
        
    }
    
}   // #285
