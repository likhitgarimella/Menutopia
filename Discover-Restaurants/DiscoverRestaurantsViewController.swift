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
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var restaurants: [AppUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.center = self.view.center
        
        hideKeyboardWhenTappedAround()
        loadRestaurants()
        restaurantsTableView.backgroundColor = UIColor.white
        
    }
    
    func loadRestaurants() {
        
        /// start when loadRestaurants func starts
        activityIndicatorView.startAnimating()
        
        Api.UserDet.observeRestaurants { (restaurant) in
            self.restaurants.append(restaurant)
            /// stop before view reloads data
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.hidesWhenStopped = true
            self.restaurantsTableView.reloadData()
        }
        
    }
    
}

extension DiscoverRestaurantsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        cell.backgroundColor = UIColor.white
        
        let restaurant = restaurants[indexPath.row]
        cell.restaurant = restaurant
        
        return cell
    }
    
}   // #64
