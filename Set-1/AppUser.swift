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
    var userName: String?
    var userEmail: String?
    
    var id: String?
    
}

extension AppUser {
    
    static func transformUser(dict: [String: Any], key: String) -> AppUser {
        
        let user = AppUser()
        user.restaurantName = dict["1) Restaurant name"] as? String
        user.restaurantEmail = dict["2) Restaurant email"] as? String
        user.userName = dict["1) User name"] as? String
        user.userEmail = dict["2) User email"] as? String
        
        user.id = key
        return user
        
    }
    
}   // #38
