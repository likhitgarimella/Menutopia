//
//  DiscoverViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 01/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    // Outlets
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var discoverRestaurants: UIView!
    @IBOutlet var discoverUsers: UIView!
    
    func SegmentFontColor() {
        
        // Selected option color
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .selected)
        // Color of other options
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        SegmentFontColor()
        
    }
    
    // Switch Index of Segmented Control
    @IBAction func switchSegment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            discoverRestaurants.alpha = 1
            discoverUsers.alpha = 0
        }
        if sender.selectedSegmentIndex == 1 {
            discoverRestaurants.alpha = 0
            discoverUsers.alpha = 1
        }
        
    }
    
}   // #50
