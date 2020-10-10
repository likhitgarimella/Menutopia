//
//  RestaurantCollectionViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase

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
        
    }
    
    func setupUserInfo() {
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
}   // #78
