//
//  UserProfileViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 30/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var editProfile: UIButton!
    @IBOutlet var logout: UIButton!
    
    var user: AppUser? {
        didSet {
            updateView2()
        }
    }
    
    @IBOutlet var profileCollectionView: UICollectionView!
    
    var posts: [UserPostModel] = []
    
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
    
    func updateView2() {
        
        self.userNameLabel.text = user!.userUsername
        
    }
    
    func Properties() {
        
        editProfile.layer.cornerRadius = 16
        logout.layer.cornerRadius = 16
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        
        Properties()
        
        fetchMyPosts()
        
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
    
}   // #98
