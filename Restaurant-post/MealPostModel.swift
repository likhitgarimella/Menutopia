//
//  MealPostModel.swift
//  Snapfood
//
//  Created by Likhit Garimella on 04/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
import FirebaseAuth

class MealPostModel {
    
    /// Remodel Post class, bcuz it currently doesn't have a post id property
    var id: String?
    
    var uid: String?
    
    var photoUrl: String?
    
    var mealName: String?
    var mealDesc: String?
    var mealPrice: String?
    
    var typeLabel: String?
    var genreLabel: String?
    var cuisineLabel: String?
    
    var timestampVal: Int?
    
}

extension MealPostModel {
    
    // Photo
    static func transformPostPhoto(dict: [String: Any], key: String) -> MealPostModel {
        
        let post = MealPostModel()
        /// Remodel Post class, bcuz it currently doesn't have a post id property
        post.id = key
        post.uid = dict["1) uid"] as? String
        post.photoUrl = dict["2) Photo Url"] as? String
        post.mealName = dict["3) Meal Name"] as? String
        post.mealDesc = dict["4) Meal Desc"] as? String
        post.mealPrice = dict["5) Meal Price"] as? String
        post.typeLabel = dict["6) Meal Type"] as? String
        post.genreLabel = dict["7) Meal Genre"] as? String
        post.cuisineLabel = dict["8) Meal Cuisine"] as? String
        post.timestampVal = dict["9) Timestamp"] as? Int
        
        return post
        
    }
    
}   // #56
