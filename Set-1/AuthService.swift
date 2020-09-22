//
//  AuthService.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class AuthService {
    
    // Sign in
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        
        print("Sign in")
        // Firebase Auth
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
        
    }
    
    // Restaurant Sign up
    static func restaurantSignUp(name: String, email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        
        print("Restaurant Sign up")
        // Firebase Auth
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            // unique user id
            guard let uid = user?.user.uid else {
                return
            }
            
            self.setRestaurantInformation(name: name, email: email, uid: uid, onSuccess: onSuccess)
            
        })
        
    }
    
    // Set restaurant info to database
    static func setRestaurantInformation(name: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
        
        let databaseRefRest = Database.database().reference().child("Restaurants").child(uid)
        databaseRefRest.setValue(["1) Restaurant name": name, "2) Restaurant email": email])
        onSuccess()
        
    }
    
    // User Sign up
    static func userSignUp(username: String, name: String, email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        
        print("User Sign up")
        // Firebase Auth
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            // unique user id
            guard let uid = user?.user.uid else {
                return
            }
            
            self.setUserInformation(username: username, name: name, email: email, uid: uid, onSuccess: onSuccess)
            
        })
        
    }
    
    // Set user info to database
    static func setUserInformation(username: String, name: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
        
        let databaseRefUser = Database.database().reference().child("Users").child(uid)
        databaseRefUser.setValue(["1) User username": username, "2) User name": name, "3) User email": email])
        onSuccess()
        
    }
    
    // Log out
    static func logout(onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        
        do {
            try Auth.auth().signOut()
            onSuccess()
        } catch let logoutError {
            onError(logoutError.localizedDescription)
        }
        
    }
    
}   // #105
