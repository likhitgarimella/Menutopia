//
//  LoginViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 09/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
import JGProgressHUD

class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginOutlet: UIButton!
    
    func Properties() {
        
        email.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        password.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        
    }
    
    func CornerRadius() {
        
        email.layer.cornerRadius = 20
        password.layer.cornerRadius = 20
        loginOutlet.layer.cornerRadius = 20
        
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
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // dismiss keyboard
        view.endEditing(true)
        
        // Progress HUD
        let hud1 = JGProgressHUD(style: .dark)
        hud1.show(in: self.view)
        
        // validations
        guard let email = email.text, let password = password.text else {
            print("Invalid Form Input")
            return
        }
        
        // Auth service sign in
        AuthService.signIn(email: email, password: password, onSuccess: {
            print("On Success")
            hud1.indicatorView = nil
            hud1.textLabel.text = "Logged In!"
            hud1.dismiss(afterDelay: 2.0, animated: true)
            // segue to tab bar VC
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, onError: {errorString in
            // this will be the one which prints error due to auth, in console
            print(errorString!)
            hud1.indicatorView = nil
            hud1.textLabel.text = errorString!
            hud1.dismiss(afterDelay: 2.0, animated: true)
        })
        
    }
    
}   // #88
