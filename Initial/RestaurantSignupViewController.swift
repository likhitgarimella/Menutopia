//
//  RestaurantSignupViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase
import JGProgressHUD

class RestaurantSignupViewController: UIViewController {
    
    // Outlets
    @IBOutlet var restName: UITextField!
    @IBOutlet var restEmail: UITextField!
    @IBOutlet var restAddress: UITextField!
    @IBOutlet var restCityState: UITextField!
    @IBOutlet var restPhoneNo: UITextField!
    @IBOutlet var restOpenHours: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var register: UIButton!
    
    // global variable for selected image
    var selectedImage: UIImage?
    
    // image that appears on screen as profile image for restaurant
    // an Optional
    var image: UIImage? = nil
    
    func Properties() {
        
        restName.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        restEmail.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        restAddress.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        restCityState.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        restPhoneNo.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        restOpenHours.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        password.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        confirmPassword.backgroundColor = UIColor(red: 252/255, green: 239/255, blue: 238/255, alpha: 1)
        
    }
    
    func CornerRadius() {
        
        restName.layer.cornerRadius = 20
        restEmail.layer.cornerRadius = 20
        restAddress.layer.cornerRadius = 20
        restCityState.layer.cornerRadius = 20
        restPhoneNo.layer.cornerRadius = 20
        restOpenHours.layer.cornerRadius = 20
        password.layer.cornerRadius = 20
        confirmPassword.layer.cornerRadius = 20
        register.layer.cornerRadius = 20
        
    }
    
    func LeftPadding() {
        
        restName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: restName.frame.height))
        restName.leftViewMode = .always
        restEmail.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: restEmail.frame.height))
        restEmail.leftViewMode = .always
        restAddress.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: restAddress.frame.height))
        restAddress.leftViewMode = .always
        restCityState.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: restCityState.frame.height))
        restCityState.leftViewMode = .always
        restPhoneNo.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: restPhoneNo.frame.height))
        restPhoneNo.leftViewMode = .always
        restOpenHours.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: restOpenHours.frame.height))
        restOpenHours.leftViewMode = .always
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: password.frame.height))
        password.leftViewMode = .always
        confirmPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: confirmPassword.frame.height))
        confirmPassword.leftViewMode = .always
        
    }
    
    func ProfileImage() {
        
        // Profile image properties
        profileImage.layer.cornerRadius = 40
        profileImage.layer.masksToBounds = true
        
        // Add gesture for profile image present in screen
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        
    }
    
    @objc func handleSelectProfileImageView() {
        
        let pickerController = UIImagePickerController()
        // To get access to selected media files, add delegate
        pickerController.delegate = self
        /// presenting it in full screen bcuz...
        /// i want the view to change...
        /// so that viewWillAppear will work...
        pickerController.modalPresentationStyle = .fullScreen
        // present photo library
        present(pickerController, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        Properties()
        CornerRadius()
        LeftPadding()
        ProfileImage()
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // Progress HUD
    let hud1 = JGProgressHUD(style: .dark)
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        // dismiss keyboard
        view.endEditing(true)
        
        hud1.show(in: self.view)
        
        func isValidEmail(testStr:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
        
        if (restName.text?.isEmpty == false && restEmail.text?.isEmpty == false && restAddress.text?.isEmpty == false && restCityState.text?.isEmpty == false && restPhoneNo.text?.isEmpty == false && restOpenHours.text?.isEmpty == false && password.text?.isEmpty == false && confirmPassword.text?.isEmpty == false) {
            
            if (password.text == confirmPassword.text) {
                
                if(isValidEmail(testStr: restEmail.text!)) {
                    
                    // Validations
                    guard let name = restName.text, let email = restEmail.text, let address = restAddress.text, let cityState = restCityState.text, let phoneNo = restPhoneNo.text, let openHours = restOpenHours.text, let password = password.text else {
                        print("Invalid Form Input")
                        return
                    }
                    
                    // selected image should be from image
                    guard let imageSelected = self.image else {
                        print("Avatar is nil")
                        hud1.indicatorView = nil    // remove indicator
                        hud1.textLabel.text = "Profile image can't be empty"
                        hud1.dismiss(afterDelay: 1.0, animated: true)
                        return
                    }
                    
                    // image data from selected image in jpeg format & compression
                    guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                        return
                    }
                    
                    // Auth service sign up
                    AuthService.restaurantSignUp(name: name, email: email, address: address, cityState: cityState, phoneNo: phoneNo, openHours: openHours, password: password, imageData: imageData, onSuccess: {
                        print("On Success")
                        self.hud1.show(in: self.view)
                        self.hud1.indicatorView = nil
                        self.hud1.textLabel.text = "Welcome!"
                        self.hud1.dismiss(afterDelay: 1.0, animated: true)
                        // segue to tab bar VC
                        self.performSegue(withIdentifier: "restSignupToHome", sender: self)
                    }) {errorString in
                        // this will be the one which prints error due to auth, in console
                        print(errorString!)
                        self.hud1.show(in: self.view)
                        self.hud1.indicatorView = nil
                        self.hud1.textLabel.text = errorString!
                        self.hud1.dismiss(afterDelay: 1.0, animated: true)
                    }
                    
                } else {
                    hud1.show(in: self.view)
                    hud1.indicatorView = nil
                    hud1.textLabel.text = "Enter a valid email address"
                    hud1.dismiss(afterDelay: 1.0, animated: true)
                }
                
            } else {
                hud1.show(in: self.view)
                hud1.indicatorView = nil
                hud1.textLabel.text = "Password and Confirm password doesn't match"
                hud1.dismiss(afterDelay: 1.0, animated: true)
            }
            
        } else {
            // Alert
            let alertController = UIAlertController(title: "Oops!", message: "Please fill all the fields to proceed", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}

extension RestaurantSignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Selected image to display it in our profile image
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // set profile image's imageView to selected image
            profileImage.image = imageSelected
            // Store this img in an instance variable
            image = imageSelected
        }
        // Original image
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // set profile image's imageView to original image
            profileImage.image = imageOriginal
            // Store this img in an instance variable
            image = imageOriginal
        }
        
        print("Image selected from library")
        dismiss(animated: true, completion: nil)
        
    }
    
}   // #240
