//
//  RestaurantPostApi.swift
//  Snapfood
//
//  Created by Likhit Garimella on 04/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
import FirebaseDatabase

/// Write your own Api, to conveniently observe database data...

class RestaurantPostApi {
    
    var REF_POSTS = Database.database().reference().child("Restaurant-Posts").child("Details")
    
    func observePosts(completion: @escaping (MealPostModel) -> Void) {
        
        REF_POSTS.observe(.childAdded, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let newPost = MealPostModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(newPost)
            }
            
        })
        
    }
    
    func observePost(withId id: String, completion: @escaping (MealPostModel) -> Void) {
        
        REF_POSTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            
            if let dict = snapshot.value as? [String:Any] {
                let post = MealPostModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(post)
            }
            
        })
        
    }
    
    func observeLikeCount(withPostId id: String, completion: @escaping (Int) -> Void) {
        
        REF_POSTS.child(id).observe(.childChanged, with: {
            snapshot in
            print(snapshot)
            if let value = snapshot.value as? Int {
                completion(value)
            }
        })
        
    }
    
    func incrementLikes(postId: String, onSuccess: @escaping (MealPostModel) -> Void, onError: @escaping (_ errorMessage: String?) -> Void ) {
        
        let postRef = Api.RestaurantPost.REF_POSTS.child(postId)
        postRef.runTransactionBlock ({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String: AnyObject], let uid = Api.UserDet.CURRENT_USER?.uid {
                // print("Value 1: \(currentData.value)")
                var likes: Dictionary<String, Bool>
                likes = post["Likes"] as? [String: Bool] ?? [:]
                var likeCount = post["Like Count"] as? Int ?? 0
                if let _ = likes[uid] {
                    likeCount -= 1
                    likes.removeValue(forKey: uid)
                } else {
                    likeCount += 1
                    likes[uid] = true
                }
                post["Like Count"] = likeCount as AnyObject
                post["Likes"] = likes as AnyObject
                
                currentData.value = post
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                onError(error.localizedDescription)
            }
            // print("Value 2: \(snapshot?.value)")
            if let dict = snapshot?.value as? [String: Any] {
                let post = MealPostModel.transformPostPhoto(dict: dict, key: snapshot!.key)
                onSuccess(post)
            }
            
        }
        
    }
    
}   // #96
