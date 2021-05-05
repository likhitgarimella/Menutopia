//
//  UserSignupViewController.swift
//  Snapfood
//
//  Created by Likhit Garimella on 10/09/20.
//  Copyright © 2020 Likhit Garimella. All rights reserved.
//

import UIKit
// import Firebase
import JGProgressHUD

class UserSignupViewController: UIViewController {
    
    // Outlets
    @IBOutlet var userUsername: UITextField!
    @IBOutlet var userName: UITextField!
    @IBOutlet var userEmail: UITextField!
    @IBOutlet var userBio: UITextField!
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
        
        userUsername.backgroundColor = UIColor(red: 238/255, green: 241/255, blue: 254/255, alpha: 1)
        userName.backgroundColor = UIColor(red: 238/255, green: 241/255, blue: 254/255, alpha: 1)
        userEmail.backgroundColor = UIColor(red: 238/255, green: 241/255, blue: 254/255, alpha: 1)
        userBio.backgroundColor = UIColor(red: 238/255, green: 241/255, blue: 254/255, alpha: 1)
        password.backgroundColor = UIColor(red: 238/255, green: 241/255, blue: 254/255, alpha: 1)
        confirmPassword.backgroundColor = UIColor(red: 238/255, green: 241/255, blue: 254/255, alpha: 1)
        
    }
    
    func CornerRadius() {
        
        userUsername.layer.cornerRadius = 20
        userName.layer.cornerRadius = 20
        userEmail.layer.cornerRadius = 20
        userBio.layer.cornerRadius = 20
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
        userBio.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: userBio.frame.height))
        userBio.leftViewMode = .always
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
        
        hud1.dismiss(afterDelay: 2.0, animated: true)
        
        func isValidEmail(testStr:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: testStr)
        }
        
        if (userUsername.text?.isEmpty == false && userName.text?.isEmpty == false && userEmail.text?.isEmpty == false && userBio.text?.isEmpty == false && password.text?.isEmpty == false && confirmPassword.text?.isEmpty == false) {
            
            if (password.text!.trimmingCharacters(in: .whitespacesAndNewlines) == confirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)) {
                
                if(isValidEmail(testStr: userEmail.text!)) {
                    
                    // Validations
                    guard let username = userUsername.text, let name = userName.text, let email = userEmail.text, let bio = userBio.text, let password = password.text else {
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
                    AuthService.userSignUp(username: username.trimmingCharacters(in: .whitespacesAndNewlines), name: name.trimmingCharacters(in: .whitespacesAndNewlines), email: email.trimmingCharacters(in: .whitespacesAndNewlines), bio: bio.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines), imageData: imageData, onSuccess: {
                        print("On Success")
                        self.hud1.show(in: self.view)
                        self.hud1.indicatorView = nil
                        self.hud1.textLabel.text = "Welcome!"
                        self.hud1.dismiss(afterDelay: 1.0, animated: true)
                        // segue to tab bar VC
                        self.performSegue(withIdentifier: "userSignupToHome", sender: self)
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

extension UserSignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
}   // #232
