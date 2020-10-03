//
//  RestaurantPostViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 03/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
import JGProgressHUD

class RestaurantPostViewController: UIViewController, UIScrollViewDelegate {
    
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
    let names1 = ["vegetarian", "non-vegetarian", "vegan", "vegetarian1", "non-vegetarian1", "vegan1"]
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
        
        // MARK: - Horz scroll view, properties & conditions
        
        /// scroll view
        let scView = UIScrollView()
        scView.delegate = self
        
        scView.showsHorizontalScrollIndicator = false
        
        /// adding scroll view to view
        view.addSubview(scView)
        
        /// scroll view constraints
        scView.translatesAutoresizingMaskIntoConstraints = false
        scView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scView.topAnchor.constraint(equalTo: selectType.bottomAnchor, constant: 10).isActive = true
        scView.bottomAnchor.constraint(equalTo: selectGenre.topAnchor, constant: -10).isActive = true
        
        /// bg color
        scView.backgroundColor = UIColor.orange
        
        /// array count
        for j in 0 ..< names1.count {
            
            /// array index
            let name = names1[j]
            /// button
            let button = UIButton()
            /// button tag
            button.tag = j
            button.layer.cornerRadius = 15
            button.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
            button.titleLabel?.font = UIFont(name: "SFProRounded-Medium", size: 16)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            button.setTitle(name, for: .normal)
            /// add target
            button.addTarget(self, action: #selector(self.buttonEvent(_:)), for: .touchUpInside)
            /// old one
            // button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
            
            let strofMenu = names1[selectedIndex1]
            
            if (j == selectedIndex1) {
                if(strofMenu == "vegetarian") {
                    /// button selected
                    button.backgroundColor = UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0)
                    button.setTitleColor(UIColor.white, for: .normal)
                }
                /// button normal
                button.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                button.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            } else {
                /// button normal
                button.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                button.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            }
            
            /// add buttons to button array
            buttonArray1.add(button)
            
            /// button positions & dimensions
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: button.intrinsicContentSize.width + 48, height: 30)
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            /// adding button to scroll view
            scView.addSubview(button)
            
        }
        
        /// scroll view prop
        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
        
        hideKeyboardWhenTappedAround()
        
        Properties()
        CornerRadius()
        LeftPadding()
        
    }
    
    @objc func buttonEvent(_ sender: UIButton) {
        
        /// button taptic
        let taptic = UIImpactFeedbackGenerator(style: .light)
        taptic.prepare()
        taptic.impactOccurred()
        
        /// button tag
        let index = sender.tag
        /// selected index = button tag
        selectedIndex1 = index
        /// name of selected button
        let selectedButtonName = names1[index]
        /// print name of selected button & button tag
        print("\(selectedButtonName); \(sender.tag)")
        /// print that in dummy label
        foodTypeLabel.text = selectedButtonName
        
        for i in 0 ..< buttonArray1.count {
            let buttonone : UIButton = (buttonArray1[i] as! UIButton)
            if i == selectedIndex1 {
                /// button selected
                buttonone.backgroundColor = UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0)
                buttonone.setTitleColor(UIColor.white, for: .normal)
            } else {
                /// button normal
                buttonone.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                buttonone.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            }
        }
        
    }
    
}   // #211
