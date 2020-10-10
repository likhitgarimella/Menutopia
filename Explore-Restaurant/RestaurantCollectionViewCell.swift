//
//  RestaurantCollectionViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase
import SDWebImage

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
        
        tag1.text = "    \(String(describing: restaurantPost?.typeLabel))    "
        tag2.text = "    \(String(describing: restaurantPost?.genreLabel))    "
        tag3.text = "    \(String(describing: restaurantPost?.cuisineLabel))    "
        
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
        restMenuItemImage.image = UIImage(named: imageName)
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
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // initial text
        restName.text = ""
        restMealName.text = ""
        restMenuDesc.text = ""
        restItemPrice.text = ""
        tag1.text = ""
        tag2.text = ""
        tag3.text = ""
        timestampValue.text = ""
        
        // corner radius
        cardView.layer.cornerRadius = 10
        
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
        
        /// Old
        /*
        mentorPostRef = Api.MentorPost.REF_POSTS.child(mentorPost!.id!)
        incrementLikes(forRef: mentorPostRef)
        */
        
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
    
}   // #188
