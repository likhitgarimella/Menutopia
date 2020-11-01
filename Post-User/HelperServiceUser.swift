//
//  HelperServiceUser.swift
//  Snapfood
//
//  Created by Likhit Garimella on 04/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
// import FirebaseDatabase
import FirebaseStorage

class HelperServiceUser {
    
    static func uploadDataToServer(data: Data, caption: String, timestamp: Double, onSuccess: @escaping () -> Void) {
        // NSUUID
        let photoIdString = NSUUID().uuidString
        print("Photo Id String: \(photoIdString)")
        let storageRef = Storage.storage().reference(forURL: "gs://snapfood-2304acc.appspot.com/").child("UserPosts").child(photoIdString)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        // put image data
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            // get download url for image from Firebase Storage
            storageRef.downloadURL { (url, error) in
                // convert that download url to string
                if let metaImageUrl = url?.absoluteString {
                    print(metaImageUrl)
                    self.sendDataToDatabase(photoUrl: metaImageUrl, caption: caption, timestamp: timestamp, onSuccess: onSuccess)
                }
            }
        }
    }
    
    static func sendDataToDatabase(photoUrl: String, caption: String, timestamp: Double, onSuccess: @escaping () -> Void) {
        let newPostId = Api.UserPost.REF_POSTS.childByAutoId().key
        let newPostReference = Api.UserPost.REF_POSTS.child(newPostId!)
        guard let currentUser = Api.UserDet.CURRENT_USER else {
            return
        }
        let currentUserId = currentUser.uid
        // put that download url string in db
        newPostReference.setValue(["1) uid": currentUserId, "2) Photo Url": photoUrl, "3) Caption": caption, "4) Timestamp": timestamp], withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            Api.Feed.REF_FEED.child(Api.UserDet.CURRENT_USER!.uid).child(newPostId!).setValue(true)
            // Database.database().reference().child("feed").child(Api.UserDet.CURRENT_USER!.uid).child(newPostId!).setValue(true)
            
            // reference for my posts
            let myPostRef = Api.MyUserPosts.REF_MYPOSTS.child(currentUserId).child(newPostId!)
            myPostRef.setValue(true, withCompletionBlock: {
                (error, ref) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
            })
            onSuccess()
        })
    }
    
}   // #70
