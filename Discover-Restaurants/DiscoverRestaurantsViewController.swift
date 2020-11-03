//
//  DiscoverRestaurantsViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 02/11/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class DiscoverRestaurantsViewController: UIViewController {

    @IBOutlet weak var restaurantsTableView: UITableView!
    
    var restaurants: [AppUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        loadRestaurants()
        restaurantsTableView.backgroundColor = UIColor.white
        
    }
    
    func loadRestaurants() {
        
        Api.UserDet.observeRestaurants { (restaurant) in
            self.restaurants.append(restaurant)
            self.restaurantsTableView.reloadData()
        }
        
    }
    
}   // #36
