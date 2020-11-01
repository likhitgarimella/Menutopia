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
    
    func Properties() {
        
        shareOutlet.layer.cornerRadius = 6
        
        captionTextView.backgroundColor = UIColor.white
        // text view delegate
        captionTextView.delegate = self
        // acts as default text view placeholder
        captionTextView.text = "Write a caption..."
        captionTextView.textColor = UIColor.lightGray
        
        // Add gesture for profile image present in screen
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
        
    }
    
    @objc func handleSelectPhoto() {
        
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handlePost()
        
    }
    
    func handlePost() {
        
        if selectedImage != nil {
            // Enable
            self.removeOutlet.isEnabled = true
            self.shareOutlet.isEnabled = true
            shareOutlet.setTitleColor(UIColor.white, for: .normal)
            shareOutlet.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        } else {
            // Disable
            self.removeOutlet.isEnabled = false
            self.shareOutlet.isEnabled = false
            shareOutlet.setTitleColor(UIColor.lightText, for: .normal)
            shareOutlet.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        }
        
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        
        hud1.show(in: self.view)
        
        // selected image(imageSelected) should be from selectedImage
        guard let imageSelected = self.selectedImage else {
            print("Avatar is nil")
            hud1.indicatorView = nil    // remove indicator
            hud1.textLabel.text = "Profile image can't be empty"
            hud1.dismiss(afterDelay: 2.0, animated: true)
            return
        }
        // image data from selected image in jpeg format
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }
        HelperService.uploadDataToServer(data: imageData, caption: captionTextView.text!, onSuccess: {
            self.clean()
            self.tabBarController?.selectedIndex = 0
        })
    }
    
    // Reset function
    func clean() {
        self.photo.image = UIImage(named: "Placeholder-image")
        // selected image should be blank again, after we push the post to db
        self.selectedImage = nil
        self.captionTextView.text = "Write a caption..."
        // setting back text view text color to light gray, so that delegate methods work
        self.captionTextView.textColor = UIColor.lightGray
    }
    
    @IBAction func remove(_ sender: UIBarButtonItem) {
        
        clean()
        // we need to test for bad inputs again, after clearing the inputs
        handlePost()
        
    }
    
}

extension UserPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Selected image to display it in our profile image
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // Store this img in an instance variable
            selectedImage = image
            // set profile image's imageView to selected image
            photo.image = image
        }
        print("Image selected from library")
        dismiss(animated: true, completion: nil)
    }
    
}   // #164
