//
//  RestaurantSignupViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit

class RestaurantSignupViewController: UIViewController {
    
    // Outlets
    @IBOutlet var restName: UITextField!
    @IBOutlet var restEmail: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var register: UIButton!
    
    func Properties() {
        
        restName.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        restEmail.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        password.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        confirmPassword.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        
    }
    
    func CornerRadius() {
        
        restName.layer.cornerRadius = 20
        restEmail.layer.cornerRadius = 20
        password.layer.cornerRadius = 20
        confirmPassword.layer.cornerRadius = 20
        register.layer.cornerRadius = 20
        
    }
    
    func LeftPadding() {
        
        restName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: restName.frame.height))
        restName.leftViewMode = .always
        restEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: restEmail.frame.height))
        restEmail.leftViewMode = .always
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
    
}   // #64
