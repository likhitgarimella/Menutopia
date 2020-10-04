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
    
    var mealName: String?
    var photoUrl: String?
    var mealDesc: String?
    var mealPrice: String?
    var typeLabel: String?
    var genreLabel: String?
    var cuisineLabel: String?
    
    var uid: String?
    
    /// Remodel Post class, bcuz it currently doesn't have a post id property
    var id: String?
    
}

extension MealPostModel {
    
    // Photo
    static func transformPostPhoto(dict: [String: Any], key: String) -> MealPostModel {
        
        let post = MealPostModel()
        /// Remodel Post class, bcuz it currently doesn't have a post id property
        post.id = key
        post.mealName = dict["mealName"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        post.mealDesc = dict["mealDesc"] as? String
        post.mealPrice = dict["mealPrice"] as? String
        post.typeLabel = dict["typeLabel"] as? String
        post.genreLabel = dict["genreLabel"] as? String
        post.cuisineLabel = dict["cuisineLabel"] as? String
        post.uid = dict["uid"] as? String
        
        return post
        
    }
    
}   // #51
