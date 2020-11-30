//
//  RestaurantTableViewCell.swift
//  Snapfood
//
//  Created by Likhit Garimella on 03/11/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase

class RestaurantTableViewCell: UITableViewCell {
    
    // Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var contactButton: UIButton!
    
    var restaurant: AppUser? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        
        nameLabel.text = restaurant?.restaurantName
        addressLabel.text = "\((restaurant?.restAddress)!), \((restaurant?.restCityState)!), \((restaurant?.restOpenHours)!)"
        phoneLabel.text = restaurant?.restPhone
        
        if let photoUrlString = restaurant?.restProfilePhotoUrl {
            let photoUrl = URL(string: photoUrlString)
            profileImage.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholder-image"))
        }
        
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
        contactButton.addTarget(self, action: #selector(self.callAction), for: .touchUpInside)
        
    }
    
    @objc func callAction() {
        
        if let url = URL(string: "tel://\(phoneLabel.text!)"),
        UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
    }
    
}   // #82
