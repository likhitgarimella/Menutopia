//
//  RestaurantCollectionViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
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
        
        
        
    }
    
    func setupUserInfo() {
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

}   // #50
