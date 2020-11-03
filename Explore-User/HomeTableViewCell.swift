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
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var likeCountButton: UIButton!
    @IBOutlet var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    }

}   // #38
