//
//  HomeTableViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 03/11/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase

/// If a View needs data, it should ask controllers...

class HomeTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var likeCountButton: UIButton!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet weak var timestampValue: UILabel!
    
    // linking home VC & home table view cell
    var homeVC: FeedViewController?
    
    var userPost: UserPostModel? {
        didSet {
            updateView()
        }
    }
    
    /// when this user property is set..
    /// we'll let the cell download the correspoding cell..
    var user: AppUser? {
        didSet {
            setupUserInfo()
        }
    }
    
    func updateView() {
        
        captionLabel.text = userPost?.caption
        
        if let photoUrlString = userPost?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            postImageView.sd_setImage(with: photoUrl)
        }
        
        /// Timestamp
        if let seconds = userPost?.timestampVal {
            let timeStampDate = NSDate(timeIntervalSince1970: seconds)
            let pastDate = Date(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, h:mm a"
            timestampValue.text = dateFormatter.string(from: timeStampDate as Date)
            timestampValue.text = pastDate.timeAgoDisplay()
        }
        
        setupUserInfo()
        
        /// Update like
        updateLike(post: userPost!)
        
        /// New #1
        self.updateLike(post: self.userPost!)
        
    }
    
    func updateLike(post: UserPostModel) {
        
        print(post.isLiked)
        /// we first checked if its true, and no one liked this post before..
        /// or if probably someone did, but the current user did not..
        /// then we display, non-selected like icon..
        /// otherwise, display likeSelected icon..
        let imageName = post.likes == nil || !post.isLiked! ? "like-unselected" : "like-selected"
        likeImageView.image = UIImage(named: imageName)
        /// Below commented snippet can be put in 1 line.. as above..
        /* if post.isLiked == false {
            likeImageView.image = UIImage(named: "like")
        } else {
            likeImageView.image = UIImage(named: "likeSelected")
        } */
        
        // We now update like count
        /// Use optional chaining with guard
        guard let count = post.likeCount else {
            return
        }
        if count != 0 {
            likeCountButton.setTitle("\(count) likes", for: .normal)
        } else {
            likeCountButton.setTitle("Be the first to like this", for: .normal)
        }
        
    }
    
    /// New setupUserInfo() func
    /// previously, our cell had to go look up the db for a user based on the uid...
    /// it now knows all that information already...
    func setupUserInfo() {
        
        nameLabel.text = user?.userUsername
        
    }

    /// This is only called when a cell is loaded in a memory...
    /// It's not called when a cell is reused later...
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = ""
        captionLabel.text = ""
        
        let tapGestureForLikeImageView = UITapGestureRecognizer(target: self, action: #selector(likeImageViewTouch))
        likeImageView.addGestureRecognizer(tapGestureForLikeImageView)
        likeImageView.isUserInteractionEnabled = true
        
    }
    
    @objc func likeImageViewTouch() {
        
        Api.UserPost.incrementLikes(postId: userPost!.id!, onSuccess: { (post) in
            self.updateLike(post: post)
            /// New #2
            /// Now the post property of the cell is updated right after a like/dislike
            self.userPost?.likes = post.likes
            self.userPost?.isLiked = post.isLiked
            self.userPost?.likeCount = post.likeCount
        }) { (errorMessage) in
            // hud
            print(errorMessage)
        }
        
    }
    
    /// We can erase all old data before a cell is reused...
    /// this method will be called right before a cell is reused...
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = UIImage(named: "user-prof-pic")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    }
    
}   // #156
