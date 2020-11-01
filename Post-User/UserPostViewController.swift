//
//  UserPostViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 03/10/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase
import JGProgressHUD

class UserPostViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var captionTextView: UITextView!
    @IBOutlet var shareOutlet: UIButton!
    
    @IBOutlet var removeOutlet: UIButton!
    
    var selectedImage: UIImage?
    
    // Delegate function
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    // Delegate function
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write a caption..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    // progress hud
    let hud1 = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
    }
    
}   // #50
