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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var restaurants: [AppUser] = []
    
    // copy of reference
    var filteredData: [AppUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.center = self.view.center
        
        searchBar.delegate = self
        
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
            self.filteredData = self.restaurants
            self.restaurantsTableView.reloadData()
        }
        
    }
    
}

extension DiscoverRestaurantsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
        cell.backgroundColor = UIColor.white
        
        let restaurant = filteredData[indexPath.row]
        cell.restaurant = restaurant
        
        return cell
    }
    
}

extension DiscoverRestaurantsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == "" {
            filteredData = restaurants
        } else {
            for item in restaurants {
                if (item.restaurantName!.lowercased().contains(searchText.lowercased()) || item.restAddress!.lowercased().contains(searchBar.text!.lowercased()) || item.restCityState!.lowercased().contains(searchText.lowercased()) || item.restOpenHours!.lowercased().contains(searchText.lowercased())) {
                    filteredData.append(item)
                }
            }
        }
        
        self.restaurantsTableView.reloadData()
        
    }
    
}   // #94
