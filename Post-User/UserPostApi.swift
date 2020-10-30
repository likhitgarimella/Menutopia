//
//  UserPostApi.swift
//  Snapfood
//
//  Created by Likhit Garimella on 04/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
import FirebaseDatabase

/// Write your own Api, to conveniently observe database data...

class UserPostApi {
    
    var REF_POSTS = Database.database().reference().child("User-Posts").child("Details")
    
    func observePosts(completion: @escaping (UserPostModel) -> Void) {
        
        REF_POSTS.observe(.childAdded, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let newPost = UserPostModel.transformPostPhoto(dict: dict, key: snapshot.key)
                completion(newPost)
            }
            
        })
        
    }
    
    func observePost(withId id: String, completion: @escaping (UserPostModel) -> Void) {
        
        REF_POSTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            
            if let dict = snapshot.value as? [String:Any] {
                let post = UserPostModel.transformPostPhoto(dict: dict, key: snapshot.key)
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
    
}   // #58
