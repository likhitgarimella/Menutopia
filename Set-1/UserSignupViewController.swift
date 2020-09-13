//
//  UserSignupViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
import JGProgressHUD

class UserSignupViewController: UIViewController {
    
    // Outlets
    @IBOutlet var userUsername: UITextField!
    @IBOutlet var userName: UITextField!
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var register: UIButton!
    
    func Properties() {
        
        userUsername.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        userName.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        userEmail.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        password.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        confirmPassword.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        
    }
    
    func CornerRadius() {
        
        userUsername.layer.cornerRadius = 20
        userName.layer.cornerRadius = 20
        userEmail.layer.cornerRadius = 20
        password.layer.cornerRadius = 20
        confirmPassword.layer.cornerRadius = 20
        register.layer.cornerRadius = 20
        
    }
    
    func LeftPadding() {
        
        userUsername.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: userUsername.frame.height))
        userUsername.leftViewMode = .always
        userName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: userName.frame.height))
        userName.leftViewMode = .always
        userEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: userEmail.frame.height))
        userEmail.leftViewMode = .always
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: password.frame.height))
        password.leftViewMode = .always
        confirmPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: confirmPassword.frame.height))
        confirmPassword.leftViewMode = .always
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        Properties()
        CornerRadius()
        LeftPadding()
        
    }
    
}   // #70
