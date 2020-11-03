//
//  RestaurantTableViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 03/11/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var contactButton: UIButton!
    
    var restaurant: AppUser? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        nameLabel.text = restaurant?.restaurantName
        
        configureContactButton()
        
    }
    
    func configureContactButton() {
        
        // contactButton.layer.borderWidth = 1
        // contactButton.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232/255, alpha: 1).cgColor
        contactButton.layer.cornerRadius = 5
        contactButton.clipsToBounds = true
        ///
        contactButton.setTitleColor(UIColor.white, for: .normal)
        contactButton.backgroundColor = UIColor(red: 69/255, green: 142/255, blue: 255/255, alpha: 1)
        contactButton.setTitle("Contact", for: .normal)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    }
    
}   // #60
