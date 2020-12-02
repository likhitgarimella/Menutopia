//
//  DiscoverPeopleViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 02/11/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class DiscoverPeopleViewController: UIViewController {
    
    @IBOutlet weak var peopleTableView: UITableView!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users: [AppUser] = []
    
    // copy of reference
    var filteredData: [AppUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.center = self.view.center
        
        searchBar.delegate = self
        
        hideKeyboardWhenTappedAround()
        loadUsers()
        peopleTableView.backgroundColor = UIColor.white
        
    }
    
    func loadUsers() {
        
        /// start when loadUsers func starts
        activityIndicatorView.startAnimating()
        
        Api.UserDet.observeUsers { (user) in
            self.isFollowing(userId: user.id!, completed: {
                (value) in
                user.isFollowing = value
                self.users.append(user)
                /// stop before view reloads data
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.hidesWhenStopped = true
                self.filteredData = self.users
                self.peopleTableView.reloadData()
            })
        }
        
    }
    
    func isFollowing(userId: String, completed: @escaping (Bool) -> Void) {
        
        Api.Follow.isFollowing(userId: userId, completed: completed)
        
    }
    
}

extension DiscoverPeopleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as! PeopleTableViewCell
        cell.backgroundColor = UIColor.white
        
        let user = filteredData[indexPath.row]
        cell.user = user
        
        return cell
    }
    
}

extension DiscoverPeopleViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == "" {
            filteredData = users
        } else {
            for item in users {
                if (item.userUsername!.lowercased().contains(searchText.lowercased()) || item.userName!.lowercased().contains(searchBar.text!.lowercased())) {
                    filteredData.append(item)
                }
            }
        }
        
        self.peopleTableView.reloadData()
        
    }
    
}   // #104
