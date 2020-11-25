//
//  ExploreRestaurantViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 13/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase

class ExploreRestaurantViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet var restaurantFeedCollectionView: UICollectionView!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    // reference to store MealPostModel class info
    var restaurantPosts = [MealPostModel]()
    
    // copy of reference
    var realRestaurantPosts = [MealPostModel]()
    
    // reference to store User class info
    var users = [AppUser]()
    
    // load restaurant posts
    func loadPosts() {
        
        /// start when loadPosts func starts
        activityIndicatorView.startAnimating()
        
        Api.RestaurantPost.observePosts { (post) in
            guard let postId = post.uid else {
                return
            }
            /// fetch user data in mentor posts
            self.fetchUser(uid: postId, completed: {
                self.restaurantPosts.append(post)
                print(self.restaurantPosts)
                /// stop before view reloads data
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.hidesWhenStopped = true
                self.realRestaurantPosts = self.restaurantPosts
                self.restaurantFeedCollectionView.reloadData()
            })
        }
        
    }
    
    /// it's job is to, given a user id, look up the corresponding user on db...
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        
        Api.UserDet.observeRestaurant(withId: uid, completion: { (user) in
            self.users.append(user)
            completed()
        })
        
    }
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let restaurantCell = restaurantFeedCollectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as! RestaurantCollectionViewCell
        let post = restaurantPosts[indexPath.row]
        let user = users[indexPath.row]
        restaurantCell.restaurantPost = post
        restaurantCell.user = user
        // linking home VC & home table view cell
        restaurantCell.restaurantFeedVC = self
        return restaurantCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        searchView.backgroundColor = UIColor.white
        return searchView
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.restaurantPosts.removeAll()
        
        for item in self.realRestaurantPosts {
            if (item.mealName!.lowercased().contains(searchBar.text!.lowercased())) {
                self.restaurantPosts.append(item)
            }
        }
        
        if (searchBar.text!.isEmpty) {
            self.restaurantPosts = self.realRestaurantPosts
        }
        
        self.restaurantFeedCollectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        activityIndicatorView.center = self.view.center
        
        // Register CollectionViewCell 'RestaurantCollectionViewCell' here
        restaurantFeedCollectionView.register(UINib.init(nibName: "RestaurantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCollectionViewCell")
        if let flowLayout = restaurantFeedCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        loadPosts()
        
        self.tabBarController?.delegate = self
        
        restaurantFeedCollectionView.delegate = self
        restaurantFeedCollectionView.dataSource = self
        
    }
    
    // Scroll to top in coll view when tapped on tab bar icon
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        let tabBarIndex = tabBarController.selectedIndex
        // print(tabBarIndex)
        
        if tabBarIndex == 0 {
            self.restaurantFeedCollectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
    
}   // #140
