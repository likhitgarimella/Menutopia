//
//  FeedViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 01/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase
import SDWebImage

class FeedViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    // reference to store Post class info
    var posts = [UserPostModel]()
    
    // reference to store User class info
    var users = [AppUser]()
    
    func Properties() {
        
        tableView.backgroundColor = UIColor.white
        tableView.estimatedRowHeight = 470
        tableView.rowHeight = UITableView.automaticDimension
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.center = self.view.center
        
        Properties()
        
        loadPosts()
        
    }
    
    func loadPosts() {
        
        // start when loadPosts func starts
        activityIndicatorView.startAnimating()
        
        Api.Feed.observeFeed(withId: Api.UserDet.CURRENT_USER!.uid, completion: {
            (post) in
            guard let postId = post.uid else {
                return
            }
            self.fetchUser(uid: postId, completed: {
                self.posts.append(post)
                // print(self.posts)
                // stop before tablew view reloads data
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.hidesWhenStopped = true
                self.tableView.reloadData()
            })
        })
        
        /// Remove feed posts (on unfollow)
        Api.Feed.observeFeedRemoved(withId: Api.UserDet.CURRENT_USER!.uid, completion: {
            (post) in
            // print(key)
            /* for (index, post) in self.posts.enumerated() {
                if post.id == key {
                    self.posts.remove(at: index)
                }
            } */
            /// this filter is more efficient, and same as above for loop
            self.posts = self.posts.filter { $0.id != post.id }
            /// real time query for posts and users count on follow and unfollow
            self.users = self.users.filter { $0.id != post.uid }
            self.tableView.reloadData()
        })
        
    }
    
    /// it's job is to...
    /// given a user id, look up the corresponding user on db...
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        
        Api.UserDet.observeUser(withId: uid, completion: { (user) in
            self.users.append(user)
            completed()
        })
        
    }
    
}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! HomeTableViewCell
        cell.backgroundColor = UIColor.white
        let post = posts[indexPath.row]
        let user = users[indexPath.row]
        cell.post = post
        cell.user = user
        // linking home VC & home table view cell
        cell.homeVC = self
        return cell
    }
    
}   // #114
