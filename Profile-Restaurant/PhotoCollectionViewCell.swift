//
//  PhotoCollectionViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 01/07/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    // Outlets
    @IBOutlet var cardView: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var restMealName: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var restMenuDesc: UILabel!
    @IBOutlet weak var restItemPrice: UILabel!
    
    @IBOutlet weak var tag1: UILabel!
    @IBOutlet weak var tag2: UILabel!
    @IBOutlet weak var tag3: UILabel!
    
    @IBOutlet var likeCountButton: UIButton!
    
    var post: MealPostModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        restMealName.text = post?.mealName
        
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            photo.sd_setImage(with: photoUrl)
        }
        
        restMenuDesc.text = post?.mealDesc
        restItemPrice.text = post?.mealPrice
        
        /// more spaces here
        // tag1.text = (" " + (post?.typeLabel)! + "            ")
        // tag2.text = (" " + (post?.genreLabel)! + "            ")
        // tag3.text = (" " + (post?.cuisineLabel)! + "            ")
        
        tag1.text = " \((post?.typeLabel)!)      "
        tag2.text = " \((post?.genreLabel)!)      "
        tag3.text = " \((post?.cuisineLabel)!)      "
        
        /// Update like
        updateLike(post: post!)
        
        /// New
        self.updateLike(post: self.post!)
        
    }
    
    func updateLike(post: MealPostModel) {
        
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
        restMealName.text = ""
        restMenuDesc.text = ""
        restItemPrice.text = ""
        tag1.text = ""
        tag2.text = ""
        tag3.text = ""
        
        // number of lines
        restMealName.numberOfLines = 0
        restMenuDesc.numberOfLines = 0
        restItemPrice.numberOfLines = 0
        tag1.numberOfLines = 0
        tag2.numberOfLines = 0
        tag3.numberOfLines = 0
        
        // corner radius
        cardView.layer.cornerRadius = 10
        photo.layer.cornerRadius = 20
        tag1.layer.masksToBounds = true
        tag1.layer.cornerRadius = tag1.bounds.height/2
        tag2.layer.masksToBounds = true
        tag2.layer.cornerRadius = tag2.bounds.height/2
        tag3.layer.masksToBounds = true
        tag3.layer.cornerRadius = tag3.bounds.height/2
        
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
    
}   // #122
