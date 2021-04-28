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

class UserPostViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var captionTextView: UITextView!
    @IBOutlet var shareOutlet: UIButton!
    
    @IBOutlet var removeOutlet: UIButton!
    
    // MARK: - Declarations
    
    var selectedImage: UIImage?
    
    /// progress hud
    let hud1 = JGProgressHUD(style: .dark)
    
    let imagePicker = UIImagePickerController()
    
    // MARK: - Functions
    
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
    
    func Properties() {
        
        shareOutlet.layer.cornerRadius = 20
        
        captionTextView.layer.borderWidth = 0.5
        captionTextView.layer.borderColor = UIColor.lightGray.cgColor
        captionTextView.backgroundColor = UIColor.white
        // text view delegate
        captionTextView.delegate = self
        // acts as default text view placeholder
        captionTextView.text = "Write a caption..."
        captionTextView.textColor = UIColor.lightGray
        
    }
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        hideKeyboardWhenTappedAround()
        Properties()
        
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
            photo.image = image
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
    */
    
    // MARK: - Share button
    
    @IBAction func shareButton(_ sender: UIButton) {
        
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
        
        // Upload data
        HelperServiceUser.uploadDataToServer(data: imageData, caption: captionTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines), timestamp: Double(Int(truncating: timestamp)), onSuccess: {
            self.clean()
            self.hud1.dismiss()
            self.tabBarController?.selectedIndex = 1
        })
        
    }
    
    // Reset function
    func clean() {
        self.photo.image = UIImage(named: "placeholder-image")
        // selected image should be blank again, after we push the post to db
        self.selectedImage = nil
        self.captionTextView.text = "Write a caption..."
        // setting back text view text color to light gray, so that delegate methods work
        self.captionTextView.textColor = UIColor.lightGray
    }
    
    @IBAction func remove(_ sender: UIBarButtonItem) {
        
        let taptic = UIImpactFeedbackGenerator(style: .light)
        taptic.prepare()
        taptic.impactOccurred()
        
        clean()
        // we need to test for bad inputs again, after clearing the inputs
        // handlePost()
        
    }
    
}   // #198
