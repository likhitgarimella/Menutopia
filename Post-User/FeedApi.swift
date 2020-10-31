//
//  FeedApi.swift
//  Snapfood
//
//  Created by Likhit Garimella on 31/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
import Firebase

class FeedApi {
    
    var REF_FEED = Database.database().reference().child("Feed")
    
    func observeFeed(withId id: String, completion: @escaping (UserPostModel) -> Void) {
        REF_FEED.child(id).observe(.childAdded, with: {
            snapshot in
            let key = snapshot.key
            Api.UserPost.observePost(withId: key, completion: {
                (post) in
                completion(post)
            })
        })
    }
    
    func observeFeedRemoved(withId id: String, completion: @escaping (UserPostModel) -> Void) {
        REF_FEED.child(id).observe(.childRemoved, with: {
            snapshot in
            let key = snapshot.key
            Api.UserPost.observePost(withId: key) { (post) in
                completion(post)
            }
        })
    }
    
}   // #38
