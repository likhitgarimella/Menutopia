//
//  RestaurantCollectionViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase
// import SDWebImage

/// If a View needs data, it should ask controllers...

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet var cardView: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var restProfilePic: UIImageView!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restDetails: UILabel!
    
    @IBOutlet weak var restMealName: UILabel!
    @IBOutlet weak var restMenuItemImage: UIImageView!
    @IBOutlet weak var restMenuDesc: UILabel!
    @IBOutlet weak var restItemPrice: UILabel!
    
    @IBOutlet weak var tag1: UILabel!
    @IBOutlet weak var tag2: UILabel!
    @IBOutlet weak var tag3: UILabel!
    
    @IBOutlet var restLikeImageView: UIImageView!
    @IBOutlet var likeCountButton: UIButton!
    
    @IBOutlet weak var timestampValue: UILabel!
    
    // linking feed VC & post cell
    var restaurantFeedVC: ExploreRestaurantViewController?
    
    var restaurantPost: MealPostModel? {
        didSet {
            updateView()
        }
    }
    
    /// when this user property is set..
    /// we'll let the cell download the correspoding cell..
    var user: AppUser? {
        didSet {
            setupUserInfo()
            restDetails.text = "\((user?.restAddress)!), \((user?.restCityState)!), \((user?.restPhone)!), \((user?.restOpenHours)!)"
        }
    }
    
    func updateView() {
        
        restMealName.text = restaurantPost?.mealName
        
        if let photoUrlString = restaurantPost?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            restMenuItemImage.sd_setImage(with: photoUrl)
        }
        
        restMenuDesc.text = restaurantPost?.mealDesc
        restItemPrice.text = restaurantPost?.mealPrice
        
        tag1.text = (" " + (restaurantPost?.typeLabel)! + "            ")
        tag2.text = (" " + (restaurantPost?.genreLabel)! + "            ")
        tag3.text = (" " + (restaurantPost?.cuisineLabel)! + "            ")
        
        /// Timestamp
        if let seconds = restaurantPost?.timestampVal {
            let timeStampDate = NSDate(timeIntervalSince1970: seconds)
            let pastDate = Date(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, h:mm a"
            timestampValue.text = dateFormatter.string(from: timeStampDate as Date)
            timestampValue.text = pastDate.timeAgoDisplay()
        }
        
        setupUserInfo()
        
        /// Update like
        updateLike(post: restaurantPost!)
        
        /// New
        self.updateLike(post: self.restaurantPost!)
        
    }
    
    func updateLike(post: MealPostModel) {
        
        // print(post.isLiked)
        /// we first checked if its true, and no one liked this post before..
        /// or if probably someone did, but the current user did not..
        /// then we display, non-selected like icon..
        /// otherwise, display likeSelected icon..
        let imageName = post.likes == nil || !post.isLiked! ? "likeOff" : "likeOn"
        restLikeImageView.image = UIImage(named: imageName)
        /// Below commented snippet can be put in 1 line.. as above..
        /* if post.isLiked == false {
            likeImageView.image = UIImage(named: "like")
        } else {
            likeImageView.image = UIImage(named: "likeSelected")
        } */
        
        // We now update like count
        /// Use optional chaining with guard
        guard let count = post.likeCount else {
            return
        }
        if count != 0 {
            likeCountButton.setTitle("\(count) likes", for: .normal)
        } else {
            likeCountButton.setTitle("0 likes", for: .normal)
        }
        
    }
    
    /// New setupUserInfo() func
    /// previously, our cell had to go look up the db for a user based on the uid...
    /// it now knows all that information already...
    func setupUserInfo() {
        
        restName.text = user?.restaurantName
        if let photoUrlString = user?.restProfilePhotoUrl {
            let photoUrl = URL(string: photoUrlString)
            restProfilePic.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholder-image"))
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // initial text
        restName.text = ""
        restDetails.text = ""
        restMealName.text = ""
        restMenuDesc.text = ""
        restItemPrice.text = ""
        tag1.text = ""
        tag2.text = ""
        tag3.text = ""
        timestampValue.text = ""
        
        // number of lines
        restName.numberOfLines = 0
        restDetails.numberOfLines = 0
        restMealName.numberOfLines = 0
        restMenuDesc.numberOfLines = 0
        restItemPrice.numberOfLines = 0
        tag1.numberOfLines = 0
        tag2.numberOfLines = 0
        tag3.numberOfLines = 0
        
        // corner radius
        cardView.layer.cornerRadius = 10
        restProfilePic.layer.cornerRadius = 25
        restMenuItemImage.layer.cornerRadius = 20
        tag1.layer.masksToBounds = true
        tag1.layer.cornerRadius = tag1.bounds.height/2
        tag2.layer.masksToBounds = true
        tag2.layer.cornerRadius = tag2.bounds.height/2
        tag3.layer.masksToBounds = true
        tag3.layer.cornerRadius = tag3.bounds.height/2
        
        // shadow properties
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowRadius = 2.0
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false
        
        // constraint
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthConstraint.constant = screenWidth - (2 * 12)
        
        // Tap gesture for like image on tap
        let tapGestureForLikeImageView = UITapGestureRecognizer(target: self, action: #selector(likeImageViewTouch))
        restLikeImageView.addGestureRecognizer(tapGestureForLikeImageView)
        restLikeImageView.isUserInteractionEnabled = true
        
    }
    
    @objc func likeImageViewTouch() {
        
        /// New
        Api.RestaurantPost.incrementLikes(postId: restaurantPost!.id!, onSuccess: { (post) in
            self.updateLike(post: post)
            /// New #2
            /// Now the post property of the cell is updated right after a like/dislike
            self.restaurantPost?.likes = post.likes
            self.restaurantPost?.isLiked = post.isLiked
            self.restaurantPost?.likeCount = post.likeCount
        }) { (errorMessage) in
            // hud
            print(errorMessage!)
        }
        
    }
    
    /// We can erase all old data before a cell is reused...
    /// this method will be called right before a cell is reused...
    override func prepareForReuse() {
        super.prepareForReuse()
        
        restProfilePic.image = UIImage(named: "placeholder-image")
        
    }
    
}   // #216
