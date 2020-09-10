//
//  RestaurantSignupViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
import JGProgressHUD

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
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        func isValidEmail(testStr:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
        
        if (restName.text?.isEmpty == false && restEmail.text?.isEmpty == false && password.text?.isEmpty == false && confirmPassword.text?.isEmpty == false) {
            
            if (password.text == confirmPassword.text) {
                
                
                
            }
            
        }
        
        // Progress HUD
        let hud1 = JGProgressHUD(style: .dark)
        hud1.show(in: self.view)
        
        // validations
        guard let name = restName.text, let email = restEmail.text, let password = password.text else {
            print("Invalid Form Input")
            return
        }
        
        // Auth service sign up
        AuthService.restaurantSignUp(name: name, email: email, password: password, onSuccess: {
            print("On Success")
            hud1.indicatorView = nil
            hud1.textLabel.text = "Welcome!"
            hud1.dismiss(afterDelay: 2.0, animated: true)
            // segue to tab bar VC
            self.performSegue(withIdentifier: "goToHome", sender: self)
        }) {errorString in
            // this will be the one which prints error due to auth, in console
            print(errorString!)
            hud1.indicatorView = nil
            hud1.textLabel.text = errorString!
            hud1.dismiss(afterDelay: 2.0, animated: true)
        }
        
    }
    
}   // #111
