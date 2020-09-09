//
//  LoginViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 09/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    func Properties() {
        
        email.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        password.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        
    }
    
    func CornerRadius() {
        
        email.layer.cornerRadius = 20
        password.layer.cornerRadius = 20
        
    }
    
    func LeftPadding() {
        
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: email.frame.height))
        email.leftViewMode = .always
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: password.frame.height))
        password.leftViewMode = .always
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        Properties()
        CornerRadius()
        LeftPadding()
        
    }
    
}   // #52
