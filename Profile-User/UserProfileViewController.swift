//
//  UserProfileViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 30/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var userUsernameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var editProfile: UIButton!
    @IBOutlet var logout: UIButton!
    
    @IBOutlet var bioOutlet: UIButton!
    
    @IBOutlet var nothingToShow: UIImageView!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
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
        
        // start when loadPosts func starts
        activityIndicatorView.startAnimating()
        
        guard let currentUser = Api.UserDet.CURRENT_USER else {
            return
        }
        Api.MyUserPosts.REF_MYPOSTS.child(currentUser.uid).observe(.childAdded, with: {
            snapshot in
            print(snapshot)
            Api.UserPost.observePost(withId: snapshot.key, completion: {
                post in
                // print(post.id)
                self.posts.append(post)
                /// stop before view reloads data
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.hidesWhenStopped = true
                self.profileCollectionView.reloadData()
            })
        })
        
    }
    
    func updateView2() {
        
        self.userUsernameLabel.text = user!.userUsername
        self.userNameLabel.text = user!.userName
        bioOutlet.isHidden = false
        profilePic.isHidden = false
        editProfile.isHidden = false
        logout.isHidden = false
        
    }
    
    func Properties() {
        
        editProfile.layer.cornerRadius = 16
        logout.layer.cornerRadius = 16
        
    }
    
    func Default() {
        
        profilePic.isHidden = true
        bioOutlet.isHidden = true
        editProfile.isHidden = true
        logout.isHidden = true
        
    }
    
    func Conditions() {
        
        // stop act ind for empty coll view
        if posts.count == 0 {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.center = self.view.center
        
        fetchUser()
        
        Properties()
        
        fetchMyPosts()
        
        Default()
        
        Conditions()
        
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
    
}   // #142
