//
//  ExploreRestaurantViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 13/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase
// import FirebaseDatabase

class ExploreRestaurantViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var restaurantFeedCollectionView: UICollectionView!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    // reference to store MealPostModel class info
    var restaurantPosts = [MealPostModel]()
    
    // reference to store User class info
    var users = [AppUser]()
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantPosts.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /// Timestamp
        /* if let seconds = mentor.timestamp {
            // let timeStampDate = NSDate(timeIntervalSince1970: seconds)
            let pastDate = Date(timeIntervalSince1970: seconds)
            // let dateFormatter = DateFormatter()
            // dateFormatter.dateFormat = "MMM d, h:mm a"
            // cell.timeAgo.text = dateFormatter.string(from: timeStampDate as Date)
            // cell.timeAgo.text = pastDate.timeAgoDisplay()
        } */
        
        let restaurantCell = restaurantFeedCollectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as! RestaurantCollectionViewCell
        let post = restaurantPosts[indexPath.row]
        let user = users[indexPath.row]
        restaurantCell.restaurantPost = post
        restaurantCell.user = user
        // linking home VC & home table view cell
        restaurantCell.restaurantFeedVC = self
        return restaurantCell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
}   // #62
