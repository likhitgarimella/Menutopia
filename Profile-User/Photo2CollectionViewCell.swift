//
//  Photo2CollectionViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 03/11/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class Photo2CollectionViewCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet var cardView: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionText: UILabel!
    
    @IBOutlet var likeCountButton: UIButton!
    
    var post: UserPostModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            photo.sd_setImage(with: photoUrl)
        }
        
        captionText.text = post?.caption
        
        /// Update like
        updateLike(post: post!)
        
        /// New
        self.updateLike(post: self.post!)
        
    }
    
    func updateLike(post: UserPostModel) {
        
        // We now update like count
        /// Use optional chaining with guard
        guard let count = post.likeCount else {
            return
        }
        if count != 0 {
            likeCountButton.setTitle("\(count) likes", for: .normal)
        } else {
            likeCountButton.setTitle("0 likes", for: .normal)
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // initial text
        captionText.text = ""
        
        // corner radius
        cardView.layer.cornerRadius = 10
        photo.layer.cornerRadius = 10
        
        // shadow properties
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowRadius = 2.0
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false
        
        // constraint
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthConstraint.constant = screenWidth - (2 * 12)
        
    }
    
}   // #85
