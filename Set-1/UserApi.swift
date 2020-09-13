//
//  UserApi.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

/// Write your own Api, to conveniently observe database data...

class UserApi {
    
    //(i)
    var REF_RESTAURANTS = Database.database().reference().child("Restaurants")
    //(ii)
    var REF_USERS = Database.database().reference().child("Users")
    
    // MARK: - Restaurant
    
    func observeRestaurant(withId uid: String, completion: @escaping (AppUser) -> Void) {
        
        REF_RESTAURANTS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String:Any] {
                let user = AppUser.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
            
        })
        
    }
    
    func observeCurrentRestaurant(completion: @escaping (AppUser) -> Void) {
        
        guard let currentUser = Auth.auth().currentUser else {
             return
        }
        
        REF_RESTAURANTS.child(currentUser.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            /// tranform data snapshot to user object
            if let dict = snapshot.value as? [String:Any] {
                let user = AppUser.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
            
        })
        
    }
    
    func observeRestaurants(completion: @escaping (AppUser) -> Void) {
        
        REF_RESTAURANTS.observe(.childAdded, with: {
            snapshot in
            
            if let dict = snapshot.value as? [String:Any] {
                let user = AppUser.transformUser(dict: dict, key: snapshot.key)
                
                /// Display list of users in 'Discover users' exclusing the current user in that
                if user.id! !=  Api.UserDet.CURRENT_RESTAURANT?.uid {
                    completion(user)
                }
            }
            
        })
        
    }
    
    var CURRENT_RESTAURANT: User? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        return nil
    }
    
    var REF_CURRENT_RESTAURANT: DatabaseReference? {
        guard let currentUser = Auth.auth().currentUser else {
             return nil
        }
        return REF_RESTAURANTS.child(currentUser.uid)
    }
    
    
    // MARK: - User
    
    func observeUser(withId uid: String, completion: @escaping (AppUser) -> Void) {
        
        REF_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String:Any] {
                let user = AppUser.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
            
        })
        
    }
    
    func observeCurrentUser(completion: @escaping (AppUser) -> Void) {
        
        guard let currentUser = Auth.auth().currentUser else {
             return
        }
        
        REF_USERS.child(currentUser.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            /// tranform data snapshot to user object
            if let dict = snapshot.value as? [String:Any] {
                let user = AppUser.transformUser(dict: dict, key: snapshot.key)
                completion(user)
            }
            
        })
        
    }
    
    func observeUsers(completion: @escaping (AppUser) -> Void) {
        
        REF_USERS.observe(.childAdded, with: {
            snapshot in
            
            if let dict = snapshot.value as? [String:Any] {
                let user = AppUser.transformUser(dict: dict, key: snapshot.key)
                
                /// Display list of users in 'Discover users' exclusing the current user in that
                if user.id! !=  Api.UserDet.CURRENT_USER?.uid {
                    completion(user)
                }
            }
            
        })
        
    }
    
    var CURRENT_USER: User? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser
        }
        return nil
    }
    
    var REF_CURRENT_USER: DatabaseReference? {
        guard let currentUser = Auth.auth().currentUser else {
             return nil
        }
        return REF_USERS.child(currentUser.uid)
    }
    
}   // #154
