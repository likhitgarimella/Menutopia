//
//  Api.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation

// Place to store all Apis

struct Api {
    
    // MARK:- User
    
    /// Firebase node - Restaurants & Users
    static var UserDet = UserApi()
    
    // MARK:- Restaurant Post
    
    /// Firebase node - RestaurantPosts-Details
    static var RestaurantPost = RestaurantPostApi()
    
    // MARK:- Profile
    
    /// Firebase node - My-Restaurant-Posts
    static var MyRestaurantPosts = MyRestaurantPostsApi()
    
}   // #31
