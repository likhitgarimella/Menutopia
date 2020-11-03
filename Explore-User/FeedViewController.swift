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
        tableView.estimatedRowHeight = 515
        tableView.rowHeight = UITableView.automaticDimension
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.center = self.view.center
        
        Properties()
        
        loadPosts()
        
    }
    
}   // #45
