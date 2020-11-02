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
    
    var users: [AppUser] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        loadUsers()
        peopleTableView.backgroundColor = UIColor.white
        
    }
    
    func loadUsers() {
        
        Api.UserDet.observeUsers { (user) in
            self.isFollowing(userId: user.id!, completed: {
                (value) in
                user.isFollowing = value
                self.users.append(user)
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
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as! PeopleTableViewCell
        cell.backgroundColor = UIColor.white
        
        let user = users[indexPath.row]
        cell.user = user
        
        return cell
    }
    
}   // #64
