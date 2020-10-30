//
//  UserPostModel.swift
//  Snapfood
//
//  Created by Likhit Garimella on 04/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserPostModel {
    
    /// Remodel Post class, bcuz it currently doesn't have a post id property
    var id: String?
    var uid: String?
    
    var photoUrl: String?
    
    var caption: String?
    
    var likes: Dictionary<String, Any>?
    var likeCount: Int?
    
    var isLiked: Bool?
    
    var timestampVal: Double?
    
}

extension UserPostModel {
    
    // Photo
    static func transformPostPhoto(dict: [String: Any], key: String) -> UserPostModel {
        
        let post = UserPostModel()
        /// Remodel Post class, bcuz it currently doesn't have a post id property
        post.id = key
        post.uid = dict["1) uid"] as? String
        post.photoUrl = dict["2) Photo Url"] as? String
        post.caption = dict["3) Caption"] as? String
        post.timestampVal = dict["4) Timestamp"] as? Double
        
        post.likeCount = dict["Like Count"] as? Int
        post.likes = dict["Likes"] as? Dictionary<String, Any>
        
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
    
}   // #64
