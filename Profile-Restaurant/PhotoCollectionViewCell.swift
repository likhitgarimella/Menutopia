//
//  PhotoCollectionViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 01/07/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    var post: MealPostModel? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            photo.sd_setImage(with: photoUrl)
        }
        
    }
    
}   // #31
