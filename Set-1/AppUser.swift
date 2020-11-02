//
//  AppUser.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation

class AppUser {
    
    var restaurantName: String?
    var restaurantEmail: String?
    var userUsername: String?
    var userName: String?
    var userEmail: String?
    
    var restAddress: String?
    var restCityState: String?
    var restPhone: String?
    var restOpenHours: String?
    
    var id: String?
    
    var isFollowing: Bool?
    
}

extension AppUser {
    
    static func transformUser(dict: [String: Any], key: String) -> AppUser {
        
        let user = AppUser()
        
        user.restaurantName = dict["1) Restaurant name"] as? String
        user.restaurantEmail = dict["2) Restaurant email"] as? String
        
        user.restAddress = dict["3) Restaurant address"] as? String
        user.restCityState = dict["4) Restaurant city & state"] as? String
        user.restPhone = dict["5) Restaurant phone"] as? String
        user.restOpenHours = dict["6) Restaurant open hours"] as? String
        
        user.userUsername = dict["1) User username"] as? String
        user.userName = dict["2) User name"] as? String
        user.userEmail = dict["3) User email"] as? String
        
        user.id = key
        return user
        
    }
    
}   // #54
