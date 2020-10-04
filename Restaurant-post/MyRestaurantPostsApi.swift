//
//  MyRestaurantPostsApi.swift
//  Snapfood
//
//  Created by Likhit Garimella on 04/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import Foundation

import FirebaseDatabase

/// Write your own Api, to conveniently observe database data...

class MyRestaurantPostsApi {
    
    var REF_MYPOSTS = Database.database().reference().child("My-Restaurant-Posts")

}   // #20
