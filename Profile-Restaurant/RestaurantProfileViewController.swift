//
//  RestaurantProfileViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 01/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase

class RestaurantProfileViewController: UIViewController {
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    
    @IBOutlet var logout: UIButton!
    
    @IBOutlet var addressOutlet: UILabel!
    @IBOutlet var cityStateOutlet: UILabel!
    @IBOutlet var phoneOutlet: UILabel!
    @IBOutlet var openhoursOutlet: UILabel!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var restaurant: AppUser? {
        didSet {
            updateView1()
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
    
    func fetchMyPosts() {
        
        /// start when fetchMyPosts func starts
        activityIndicatorView.startAnimating()
        
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
                /// stop before view reloads data
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.hidesWhenStopped = true
                self.profileCollectionView.reloadData()
            })
        })
        
    }
    
    func updateView1() {
        
        restaurantNameLabel.isHidden = false
        addressOutlet.isHidden = false
        cityStateOutlet.isHidden = false
        phoneOutlet.isHidden = false
        openhoursOutlet.isHidden = false
        self.restaurantNameLabel.text = restaurant!.restaurantName
        self.addressOutlet.text = restaurant!.restAddress
        self.cityStateOutlet.text = restaurant!.restCityState
        self.phoneOutlet.text = restaurant!.restPhone
        self.openhoursOutlet.text = restaurant!.restOpenHours
        
        profilePic.isHidden = false
        if let photoUrlString = restaurant?.restProfilePhotoUrl {
            let photoUrl = URL(string: photoUrlString)
            profilePic.sd_setImage(with: photoUrl)
        }
        
        logout.isHidden = false
        profileCollectionView.isHidden = false
        
    }
    
    func Properties() {
        
        profilePic.layer.cornerRadius = 50
        logout.layer.cornerRadius = 14
        
    }
    
    func Default() {
        
        restaurantNameLabel.isHidden = true
        profilePic.isHidden = true
        
        addressOutlet.isHidden = true
        cityStateOutlet.isHidden = true
        phoneOutlet.isHidden = true
        openhoursOutlet.isHidden = true
        
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
        
        // Register CollectionViewCell 'PhotoCollectionViewCell' here
        profileCollectionView.register(UINib.init(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        if let flowLayout = profileCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        fetchRestaurant()
        
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
            // print(errorMessage)
        })
        
    }
    
}

extension RestaurantProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
        
    }
    
}   // #184
