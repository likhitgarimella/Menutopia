//
//  FollowApi.swift
//  Snapfood
//
//  Created by Likhit Garimella on 31/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
import Firebase

class FollowApi {
    
    var REF_FOLLOWERS = Database.database().reference().child("Followers")
    var REF_FOLLOWING = Database.database().reference().child("Following")
    
    func followAction(withUser id: String) {
        Api.MyUserPosts.REF_MYPOSTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                for key in dict.keys {
                    Database.database().reference().child("Feed").child(Api.UserDet.CURRENT_USER!.uid).child(key).setValue(true)
                }
            }
        })
        REF_FOLLOWERS.child(id).child(Api.UserDet.CURRENT_USER!.uid).setValue(true)
        REF_FOLLOWING.child(Api.UserDet.CURRENT_USER!.uid).child(id).setValue(true)
    }
    
    func unFollowAction(withUser id: String) {
        Api.MyUserPosts.REF_MYPOSTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                for key in dict.keys {
                    Database.database().reference().child("Feed").child(Api.UserDet.CURRENT_USER!.uid).child(key).removeValue()
                }
            }
        })
        REF_FOLLOWERS.child(id).child(Api.UserDet.CURRENT_USER!.uid).setValue(NSNull())
        REF_FOLLOWING.child(Api.UserDet.CURRENT_USER!.uid).child(id).setValue(NSNull())
    }
    
    
    func isFollowing(userId: String, completed: @escaping (Bool) -> Void) {
        REF_FOLLOWERS.child(userId).child(Api.UserDet.CURRENT_USER!.uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let _ = snapshot.value as? NSNull {
                /// if this value is null, then the current user is not in the follower list of this user
                completed(false)
            } else {
                /// otherwise, the current user is in the follower list of this user
                completed(true)
            }
        })
    }
    
}   // #58
