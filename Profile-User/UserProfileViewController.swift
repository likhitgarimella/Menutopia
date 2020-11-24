//
//  UserProfileViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 30/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase

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
        
        /// start when fetchMyPosts func starts
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
        profileCollectionView.isHidden = false
        
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
        profileCollectionView.isHidden = true
        
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
        
        // Register CollectionViewCell 'Photo2CollectionViewCell' here
        profileCollectionView.register(UINib.init(nibName: "Photo2CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Photo2CollectionViewCell")
        if let flowLayout = profileCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
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
    
    /*
    @IBAction func bio(_ sender: UIButton) {
        
        /// Alert
        let alertController = UIAlertController(title: "Enter bio", message: "Let your friends know you better!", preferredStyle: .alert)
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
        let titleAttrString = NSMutableAttributedString(string: "Enter bio", attributes: titleFont)
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
    */
    
}

///
extension UserProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo2CollectionViewCell", for: indexPath) as! Photo2CollectionViewCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
        
    }
    
}   // #204
