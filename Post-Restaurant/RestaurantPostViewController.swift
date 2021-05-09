//
//  RestaurantPostViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 03/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase
import JGProgressHUD

class RestaurantPostViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet var mealName: UITextField!
    @IBOutlet var mealImage: UIImageView!
    @IBOutlet var mealDesc: UITextView!
    @IBOutlet var mealPrice: UITextField!
    @IBOutlet var submitOutlet: UIButton!
    
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
    
    // MARK: - Scroll view params
    
    /// scroll view
    var scview1: UIScrollView!
    var scview2: UIScrollView!
    var scview3: UIScrollView!
    /// space b/w button and cell
    let buttonPadding1: CGFloat = 10
    let buttonPadding2: CGFloat = 10
    let buttonPadding3: CGFloat = 10
    var xOffset1: CGFloat = 10
    var xOffset2: CGFloat = 10
    var xOffset3: CGFloat = 10
    
    // MARK: - Declarations
    
    var selectedImage: UIImage?
    
    let imagePicker = UIImagePickerController()
    
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
    let names1 = ["appetizer", "bread", "breakfast", "burger", "dessert", "drink", "noodles", "pasta", "pizza", "salad", "sandwich", "seafood", "soup", "starch", "steak", "taco", "wings", "-other-"]
    let names2 = ["alcoholic", "beef", "chicken", "coffee", "dairy", "egg", "fish", "frappucino", "fruit", "grains", "ice cream", "non-alcoholic", "noodle", "pancake", "shellfish", "smoothie", "sushi", "tea", "vegetable", "-other-"]
    let names3 = ["american", "cantonese", "chinese", "french", "gluten free", "indian", "italian", "japanese", "korean", "mexican", "spanish", "tex-mex", "thai", "vegan", "vegetarian", "vietnamese", "-other-"]
    
    /// progress hud
    let hud1 = JGProgressHUD(style: .dark)
    
    // MARK: - Functions
    
    func Properties() {
        
        mealName.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        mealDesc.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        mealPrice.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        
    }
    
    func CornerRadius() {
        
        mealName.layer.cornerRadius = 20
        mealImage.layer.cornerRadius = 20
        mealDesc.layer.cornerRadius = 20
        mealPrice.layer.cornerRadius = 20
        submitOutlet.layer.cornerRadius = 20
        
    }
    
    func LeftPadding() {
        
        mealName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: mealName.frame.height))
        mealName.leftViewMode = .always
        mealPrice.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: mealPrice.frame.height))
        mealPrice.leftViewMode = .always
        
    }
    
    func TextViewProperties() {
        
        mealDesc.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
        // padding for text view
        mealDesc.textContainerInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        
    }
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // MARK: - ScrollView-1 build
        
        /// scroll view
        let scview1 = UIScrollView()
        scview1.delegate = self
        
        scview1.showsHorizontalScrollIndicator = false
        
        /// adding scroll view to view
        view.addSubview(scview1)
        
        /// scroll view constraints
        scview1.translatesAutoresizingMaskIntoConstraints = false
        scview1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scview1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scview1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scview1.topAnchor.constraint(equalTo: selectType.bottomAnchor, constant: 10).isActive = true
        scview1.bottomAnchor.constraint(equalTo: selectGenre.topAnchor, constant: -10).isActive = true
        
        /// bg color
        scview1.backgroundColor = UIColor.white
        
        /// array count
        for j in 0 ..< names1.count {
            
            /// array index
            let name1 = names1[j]
            /// button
            let button1 = UIButton()
            /// button tag
            button1.tag = j
            button1.layer.cornerRadius = 15
            button1.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
            button1.titleLabel?.font = UIFont(name: "SFProRounded-Medium", size: 16)
            button1.titleLabel?.textAlignment = .center
            button1.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            button1.setTitle(name1, for: .normal)
            /// add target
            button1.addTarget(self, action: #selector(self.buttonEvent1(_:)), for: .touchUpInside)
            /// old one
            // button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
            
            let strofMenu1 = names1[selectedIndex1]
            
            if (j == selectedIndex1) {
                if(strofMenu1 == "vegetarian") {
                    /// button selected
                    button1.backgroundColor = UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0)
                    button1.setTitleColor(UIColor.white, for: .normal)
                }
                /// button normal
                button1.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                button1.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            } else {
                /// button normal
                button1.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                button1.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            }
            
            /// add buttons to button array
            buttonArray1.add(button1)
            
            /// button positions & dimensions
            button1.frame = CGRect(x: xOffset1, y: CGFloat(buttonPadding1), width: button1.intrinsicContentSize.width + 48, height: 30)
            xOffset1 = xOffset1 + CGFloat(buttonPadding1) + button1.frame.size.width
            /// adding button to scroll view
            scview1.addSubview(button1)
            
        }
        
        /// scroll view prop
        scview1.contentSize = CGSize(width: xOffset1, height: scview1.frame.height)
        
        // MARK: - ScrollView-2 build
        
        /// scroll view
        let scview2 = UIScrollView()
        scview2.delegate = self
        
        scview2.showsHorizontalScrollIndicator = false
        
        /// adding scroll view to view
        view.addSubview(scview2)
        
        /// scroll view constraints
        scview2.translatesAutoresizingMaskIntoConstraints = false
        scview2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scview2.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scview2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scview2.topAnchor.constraint(equalTo: selectGenre.bottomAnchor, constant: 10).isActive = true
        scview2.bottomAnchor.constraint(equalTo: selectCuisine.topAnchor, constant: -10).isActive = true
        
        /// bg color
        scview2.backgroundColor = UIColor.white
        
        /// array count
        for j in 0 ..< names2.count {
            
            /// array index
            let name2 = names2[j]
            /// button
            let button2 = UIButton()
            /// button tag
            button2.tag = j
            button2.layer.cornerRadius = 15
            button2.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
            button2.titleLabel?.font = UIFont(name: "SFProRounded-Medium", size: 16)
            button2.titleLabel?.textAlignment = .center
            button2.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            button2.setTitle(name2, for: .normal)
            /// add target
            button2.addTarget(self, action: #selector(self.buttonEvent2(_:)), for: .touchUpInside)
            /// old one
            // button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
            
            let strofMenu2 = names2[selectedIndex2]
            
            if (j == selectedIndex2) {
                if(strofMenu2 == "burger") {
                    /// button selected
                    button2.backgroundColor = UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0)
                    button2.setTitleColor(UIColor.white, for: .normal)
                }
                /// button normal
                button2.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                button2.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            } else {
                /// button normal
                button2.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                button2.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            }
            
            /// add buttons to button array
            buttonArray2.add(button2)
            
            /// button positions & dimensions
            button2.frame = CGRect(x: xOffset2, y: CGFloat(buttonPadding2), width: button2.intrinsicContentSize.width + 48, height: 30)
            xOffset2 = xOffset2 + CGFloat(buttonPadding2) + button2.frame.size.width
            /// adding button to scroll view
            scview2.addSubview(button2)
            
        }
        
        /// scroll view prop
        scview2.contentSize = CGSize(width: xOffset2, height: scview2.frame.height)
        
        // MARK: - ScrollView-3 build
        
        /// scroll view
        let scview3 = UIScrollView()
        scview3.delegate = self
        
        scview3.showsHorizontalScrollIndicator = false
        
        /// adding scroll view to view
        view.addSubview(scview3)
        
        /// scroll view constraints
        scview3.translatesAutoresizingMaskIntoConstraints = false
        scview3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scview3.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scview3.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scview3.topAnchor.constraint(equalTo: selectCuisine.bottomAnchor, constant: 10).isActive = true
        scview3.bottomAnchor.constraint(equalTo: submitOutlet.topAnchor, constant: -30).isActive = true
        
        /// bg color
        scview3.backgroundColor = UIColor.white
        
        /// array count
        for j in 0 ..< names3.count {
            
            /// array index
            let name3 = names3[j]
            /// button
            let button3 = UIButton()
            /// button tag
            button3.tag = j
            button3.layer.cornerRadius = 15
            button3.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
            button3.titleLabel?.font = UIFont(name: "SFProRounded-Medium", size: 16)
            button3.titleLabel?.textAlignment = .center
            button3.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            button3.setTitle(name3, for: .normal)
            /// add target
            button3.addTarget(self, action: #selector(self.buttonEvent3(_:)), for: .touchUpInside)
            /// old one
            // button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
            
            let strofMenu3 = names3[selectedIndex3]
            
            if (j == selectedIndex3) {
                if(strofMenu3 == "burger") {
                    /// button selected
                    button3.backgroundColor = UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0)
                    button3.setTitleColor(UIColor.white, for: .normal)
                }
                /// button normal
                button3.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                button3.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            } else {
                /// button normal
                button3.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                button3.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            }
            
            /// add buttons to button array
            buttonArray3.add(button3)
            
            /// button positions & dimensions
            button3.frame = CGRect(x: xOffset3, y: CGFloat(buttonPadding3), width: button3.intrinsicContentSize.width + 48, height: 30)
            xOffset3 = xOffset3 + CGFloat(buttonPadding3) + button3.frame.size.width
            /// adding button to scroll view
            scview3.addSubview(button3)
            
        }
        
        /// scroll view prop
        scview3.contentSize = CGSize(width: xOffset3, height: scview3.frame.height)
        
        hideKeyboardWhenTappedAround()
        
        Properties()
        CornerRadius()
        LeftPadding()
        TextViewProperties()
        
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        
        let taptic = UIImpactFeedbackGenerator(style: .light)
        taptic.prepare()
        taptic.impactOccurred()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
            
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (button) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
            
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
        present(alert, animated: true, completion: nil)
            
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // Store this img in an instance variable
            selectedImage = image
            // set profile image's imageView to selected image
            mealImage.image = image
        }
        print("Image selected from library")
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // handlePost()
    }
    
    /*
    func handlePost() {
        if selectedImage != nil {
            // Enable
            self.submitOutlet.isEnabled = true
            submitOutlet.setTitleColor(UIColor.white, for: .normal)
            // shareOutlet.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        } else {
            // Disable
            self.submitOutlet.isEnabled = false
            submitOutlet.setTitleColor(UIColor.lightText, for: .normal)
            // shareOutlet.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        }
    }
    */
    
    // MARK: - ScrollView-1 func
    
    @objc func buttonEvent1(_ sender: UIButton) {
        
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
    
    // MARK: - ScrollView-2 func
    
    @objc func buttonEvent2(_ sender: UIButton) {
        
        /// button taptic
        let taptic = UIImpactFeedbackGenerator(style: .light)
        taptic.prepare()
        taptic.impactOccurred()
        
        /// button tag
        let index = sender.tag
        /// selected index = button tag
        selectedIndex2 = index
        /// name of selected button
        let selectedButtonName = names2[index]
        /// print name of selected button & button tag
        print("\(selectedButtonName); \(sender.tag)")
        /// print that in dummy label
        foodGenreLabel.text = selectedButtonName
        
        for i in 0 ..< buttonArray2.count {
            let buttontwo : UIButton = (buttonArray2[i] as! UIButton)
            if i == selectedIndex2 {
                /// button selected
                buttontwo.backgroundColor = UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0)
                buttontwo.setTitleColor(UIColor.white, for: .normal)
            } else {
                /// button normal
                buttontwo.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                buttontwo.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            }
        }
        
    }
    
    // MARK: - ScrollView-3 func
    
    @objc func buttonEvent3(_ sender: UIButton) {
        
        /// button taptic
        let taptic = UIImpactFeedbackGenerator(style: .light)
        taptic.prepare()
        taptic.impactOccurred()
        
        /// button tag
        let index = sender.tag
        /// selected index = button tag
        selectedIndex3 = index
        /// name of selected button
        let selectedButtonName = names3[index]
        /// print name of selected button & button tag
        print("\(selectedButtonName); \(sender.tag)")
        /// print that in dummy label
        foodCuisineLabel.text = selectedButtonName
        
        for i in 0 ..< buttonArray3.count {
            let buttonthree : UIButton = (buttonArray3[i] as! UIButton)
            if i == selectedIndex3 {
                /// button selected
                buttonthree.backgroundColor = UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0)
                buttonthree.setTitleColor(UIColor.white, for: .normal)
            } else {
                /// button normal
                buttonthree.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1.0)
                buttonthree.setTitleColor(UIColor(red: 207/255, green: 69/255, blue: 92/255, alpha: 1.0), for: .normal)
            }
        }
        
    }
    
    
    // MARK: - Submit button
    
    @IBAction func submitButton(_ sender: UIButton) {
        
        // dismiss keyboard
        view.endEditing(true)
        
        hud1.show(in: self.view)
        
        hud1.dismiss(afterDelay: 2.0, animated: true)
        
        // Creating a timestamp
        let timestamp = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        
        // selected image(imageSelected) should be from selectedImage
        guard let imageSelected = self.selectedImage else {
            print("Avatar is nil")
            hud1.indicatorView = nil    // remove indicator
            hud1.textLabel.text = "Empty image"
            hud1.dismiss(afterDelay: 2.0, animated: true)
            return
        }
        
        // image data from selected image in jpeg format
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        if (mealName.text!.isEmpty || mealDesc.text!.isEmpty || mealPrice.text!.isEmpty || foodTypeLabel.text!.isEmpty || foodGenreLabel.text!.isEmpty || foodCuisineLabel.text!.isEmpty) {
            // Alert for empty fields
            let myAlert = UIAlertController(title: "Invalid!", message: "Please fill up all the fields and options", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        
        // Upload data
        HelperServiceRestaurant.uploadDataToServer(data: imageData, name: mealName.text!.trimmingCharacters(in: .whitespacesAndNewlines), desc: mealDesc.text!.trimmingCharacters(in: .whitespacesAndNewlines), price: mealPrice.text!, type: foodTypeLabel.text!, genre: foodGenreLabel.text!, cuisine: foodCuisineLabel.text!, timestamp: Double(Int(truncating: timestamp)), onSuccess: {
            self.clean()
            self.hud1.dismiss()
            self.tabBarController?.selectedIndex = 0
        })
        
    }
    
    // Reset function
    func clean() {
        // selected image should be blank again, after we push the post to db
        self.selectedImage = nil
        // setting back to placeholder image
        self.mealImage.image = UIImage(named: "select-profile-pic")
        // textfields should be blank again, after we push the post to db
        self.mealName.text = nil
        self.mealDesc.text = nil
        self.mealPrice.text = nil
        // setting back submit button to disabled state
        submitOutlet.isEnabled = false
    }
    
}   // #578
