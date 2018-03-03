//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit
import MKSpinner
import SkyFloatingLabelTextField

class NewSocialViewController: UIViewController {
    
    var firstBlockView: UIView!
    var eventNameField: SkyFloatingLabelTextField!
    var eventDescriptionField: SkyFloatingLabelTextField!
    
    var secondBlockView: UIView!
    var selectLibraryImageButton: UIButton!
    var selectCameraImageButton: UIButton!
    var selectedImageView: UIImageView!
    
    var thirdBlockView: UIView!
    var datePicker: UIDatePicker!

    var submitButton: UIButton!
    
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        setupNavigationBar()
        setupFirstBlock()
        setupSecondBlock()
        setupThirdBlock()
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "New Post"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewPost))
        
        submitButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        submitButton.setTitle("Submit!", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(newPost), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: submitButton)
    }
    
    func setupFirstBlock(){
        firstBlockView = UIView(frame: CGRect(x: 15, y: 85, width: view.frame.width - 30, height: 130))
        firstBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        firstBlockView.layer.cornerRadius = 10
        view.addSubview(firstBlockView)
        
        eventNameField = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 10, width: firstBlockView.frame.width - 20, height: 40))
        eventNameField.placeholder = "Event Name"
        eventNameField.title = "Event Name"
        eventNameField.textColor = .white
        eventNameField.placeholderColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        eventNameField.lineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        eventNameField.selectedTitleColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        eventNameField.titleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        eventNameField.selectedLineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        eventNameField.tintColor = .white
        firstBlockView.addSubview(eventNameField)
        
        eventDescriptionField = SkyFloatingLabelTextField(frame: CGRect(x: 10, y: 70, width: firstBlockView.frame.width - 20, height: 40))
        eventDescriptionField.placeholder = "Event Description"
        eventDescriptionField.title = "Event Description"
        eventDescriptionField.textColor = .white
        eventDescriptionField.placeholderColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        eventDescriptionField.lineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        eventDescriptionField.selectedTitleColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        eventDescriptionField.titleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        eventDescriptionField.selectedLineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        eventDescriptionField.tintColor = .white
        firstBlockView.addSubview(eventDescriptionField)
    }
    
    func setupSecondBlock(){
        secondBlockView = UIView(frame: CGRect(x: 15, y: 240, width: view.frame.width - 30, height: 200))
        secondBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        secondBlockView.layer.cornerRadius = 10
        view.addSubview(secondBlockView)
        
        selectCameraImageButton = UIButton(frame: CGRect(x: secondBlockView.frame.width/2 + 20, y: 30, width: secondBlockView.frame.width/2 - 40, height: 50))
        selectCameraImageButton.setTitle("Take Picture", for: .normal)
        selectCameraImageButton.backgroundColor = .white
        selectCameraImageButton.layer.cornerRadius = 10
        selectCameraImageButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        selectCameraImageButton.addTarget(self, action: #selector(selectPictureFromCamera), for: .touchUpInside)
        secondBlockView.addSubview(selectCameraImageButton)
        
        selectLibraryImageButton = UIButton(frame: CGRect(x: secondBlockView.frame.width/2 + 20, y: 120, width: secondBlockView.frame.width/2 - 40, height: 50))
        selectLibraryImageButton.setTitle("Select Picture", for: .normal)
        selectLibraryImageButton.layer.cornerRadius = 10
        selectLibraryImageButton.backgroundColor = .white
        selectLibraryImageButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        selectLibraryImageButton.addTarget(self, action: #selector(selectPictureFromLibrary), for: .touchUpInside)
        secondBlockView.addSubview(selectLibraryImageButton)
        
        selectedImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: secondBlockView.frame.width/2 - 20, height: secondBlockView.frame.height - 20))
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.layer.cornerRadius = 10
        selectedImageView.image = #imageLiteral(resourceName: "defaultImage")
        secondBlockView.addSubview(selectedImageView)
    }
    
    func setupThirdBlock(){
        thirdBlockView = UIView(frame: CGRect(x: 10, y: 475, width: view.frame.width - 20, height: 200))
        secondBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        thirdBlockView.layer.cornerRadius = 10
        view.addSubview(thirdBlockView)
        
        datePicker = UIDatePicker(frame: CGRect(x: 10, y: 10, width: thirdBlockView.frame.width - 20, height: thirdBlockView.frame.height - 20))
        thirdBlockView.addSubview(datePicker)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        eventNameField.resignFirstResponder()
        eventDescriptionField.resignFirstResponder()
    }
    
    @objc func cancelNewPost() {
        self.dismiss(animated: true) {
            print("Back to feed")
        }
    }
    
    @objc func selectPictureFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func selectPictureFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func newPost() {
        if eventNameField.hasText && eventDescriptionField.hasText && selectedImage != nil {
            MKFullSpinner.show("Uploading Post", animated: true)
            FirebaseDatabaseHelper.newPostWithImage(selectedImage: selectedImage, name: eventNameField.text!, description: eventDescriptionField.text!, date: datePicker.date).then { success -> Void in
                MKFullSpinner.hide()
                self.dismiss(animated: true, completion: {
                    print("Post Complete")
                })
            }
        }
        else{
            let alertController = UIAlertController(title: "Fields Blank", message:
                "Make sure you enter all required information.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension NewSocialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        selectedImageView.image = selectedImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
