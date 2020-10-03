//
//  RestaurantPostViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 03/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
import JGProgressHUD

class RestaurantPostViewController: UIViewController {
    
    // Outlets
    @IBOutlet var mealName: UITextField!
    @IBOutlet var mealDesc: UITextView!
    @IBOutlet var mealPrice: UITextField!
    @IBOutlet var sponsorOutlet: UIButton!
    
    /// reference label 1
    @IBOutlet var selectType: UILabel!
    /// reference label 2
    @IBOutlet var selectGenre: UILabel!
    /// reference label 3
    @IBOutlet var selectCuisine: UILabel!
    
    /// dummy label for food type
    @IBOutlet var foodTypeLabel: UILabel!
    /// dummy label for food genre
    @IBOutlet var foodGenreLabel: UILabel!
    /// dummy label for food cuisine
    @IBOutlet var foodCuisineLabel: UILabel!
    
    // MARK: - Scroll view
    
    /// scroll view
    var scView: UIScrollView!
    /// space b/w button and cell
    let buttonPadding: CGFloat = 10
    var xOffset: CGFloat = 10
    
    // MARK: - Declarations
    
    /// global declaration
    let button1 = UIButton.init(type: .custom)
    let button2 = UIButton.init(type: .custom)
    let button3 = UIButton.init(type: .custom)
    
    /// selected index of button in scroll view
    var selectedIndex1 : Int = 0
    var selectedIndex2 : Int = 0
    var selectedIndex3 : Int = 0
    
    /// array of buttons
    var buttonArray1 : NSMutableArray = []
    var buttonArray2 : NSMutableArray = []
    var buttonArray3 : NSMutableArray = []
    
    /// array data
    let names1 = ["vegetarian", "non-vegetarian", "vegan"]
    let names2 = ["vegetarian", "non-vegetarian", "vegan"]
    let names3 = ["vegetarian", "non-vegetarian", "vegan"]
    
    // progress hud
    let hud1 = JGProgressHUD(style: .dark)
    
    func Properties() {
        
        mealName.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        mealDesc.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        mealPrice.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        
    }
    
    func CornerRadius() {
        
        mealName.layer.cornerRadius = 20
        mealDesc.layer.cornerRadius = 20
        mealPrice.layer.cornerRadius = 20
        sponsorOutlet.layer.cornerRadius = 20
        
    }
    
    func LeftPadding() {
        
        mealName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: mealName.frame.height))
        mealName.leftViewMode = .always
        mealPrice.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: mealPrice.frame.height))
        mealPrice.leftViewMode = .always
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        Properties()
        CornerRadius()
        LeftPadding()
        
    }
    
}   // #105
