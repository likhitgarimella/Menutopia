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
    
    // MARK:- Firebase User
    
    /// Firebase node - Restaurants & Users
    static var UserDet = UserApi()
    
    // MARK:- Restaurant Post
    
    /// Firebase node - Restaurant-Posts - Details
    static var RestaurantPost = RestaurantPostApi()
    
    // MARK:- User Post
    
    /// Firebase node - User-Posts - Details
    static var UserPost = UserPostApi()
    
    // MARK:- Restaurant Profile
    
    /// Firebase node - My-Restaurant-Posts
    static var MyRestaurantPosts = MyRestaurantPostsApi()
    
    // MARK:- User Profile
    
    /// Firebase node - My-User-Posts
    static var MyUserPosts = MyUserPostsApi()
    
    // MARK:- User Panel
    
    static var Follow = FollowApi()
    static var Feed = FeedApi()
    
}   // #46
