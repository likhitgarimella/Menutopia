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
    
    var likes: Dictionary<String, Any>?
    var likeCount: Int?
    
    var isLiked: Bool?
    
    var timestampVal: Double?
    
    var addressLabel: String?
    var cityStateLabel: String?
    var phoneLabel: String?
    var openHoursLabel: String?
    
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
        post.timestampVal = dict["9) Timestamp"] as? Double
        
        post.likeCount = dict["Like Count"] as? Int
        post.likes = dict["Likes"] as? Dictionary<String, Any>
        
        post.addressLabel = dict["Address"] as? String
        post.cityStateLabel = dict["City & State"] as? String
        post.phoneLabel = dict["Phone no"] as? String
        post.openHoursLabel = dict["Open hours"] as? String
        
        if let currentUserId = Auth.auth().currentUser?.uid {
            if post.likes != nil {
                /* if post.likes[currentUserId] != nil {
                    post.isLiked = true
                } else {
                    post.isLiked = false
                } */
                /// Above commented snippet can be put in 1 line.. as below..
                post.isLiked = post.likes![currentUserId] != nil
            }
        }
        
        return post
        
    }
    
}   // #86
