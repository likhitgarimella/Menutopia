//
//  HelperServiceRestaurant.swift
//  Snapfood
//
//  Created by Likhit Garimella on 04/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
import FirebaseStorage

class HelperServiceRestaurant {
    
    static func uploadDataToServer(data: Data, name: String, desc: String, price: String, type: String, genre: String, cuisine: String, timestamp: Double, onSuccess: @escaping () -> Void) {
        // NSUUID
        let photoIdString = NSUUID().uuidString
        print("Photo Id String: \(photoIdString)")
        let storageRef = Storage.storage().reference(forURL: "gs://snapfood-2304acc.appspot.com").child("RestaurantPosts").child(photoIdString)
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
                    self.sendDataToDatabase(photoUrl: metaImageUrl, name: name, desc: desc, price: price, type: type, genre: genre, cuisine: cuisine, timestamp: timestamp, onSuccess: onSuccess)
                }
            }
        }
    }
    
    static func sendDataToDatabase(photoUrl: String, name: String, desc: String, price: String, type: String, genre: String, cuisine: String, timestamp: Double, onSuccess: @escaping () -> Void) {
        let newPostId = Api.RestaurantPost.REF_POSTS.childByAutoId().key
        let newPostReference = Api.RestaurantPost.REF_POSTS.child(newPostId!)
        guard let currentUser = Api.UserDet.CURRENT_USER else {
            return
        }
        let currentUserId = currentUser.uid
        // put that download url string in db
        newPostReference.setValue(["1) uid": currentUserId, "2) Photo Url": photoUrl, "3) Meal Name": name, "4) Meal Desc": desc, "5) Meal Price": price, "6) Meal Type": type, "7) Meal Genre": genre, "8) Meal Cuisine": cuisine, "9) Timestamp": timestamp], withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            // reference for my posts
            let myPostRef = Api.MyRestaurantPosts.REF_MYPOSTS.child(currentUserId).child(newPostId!)
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
    
}   // #66
