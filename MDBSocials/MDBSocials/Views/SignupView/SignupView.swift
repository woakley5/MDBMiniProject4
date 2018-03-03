//
//  SignupView.swift
//  MDBSocials
//
//  Created by Will Oakley on 3/3/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class SignupView: UIView {

    var fullNameField: YellowFloatingTextField!
    var usernameField: YellowFloatingTextField!
    var emailField: YellowFloatingTextField!
    var passwordField: YellowFloatingTextField!
    var selectCameraImageButton: UIButton!
    var selectLibraryImageButton: UIButton!
    var selectedImageView: UIImageView!
    var logInButton: UIButton!
    var signUpButton: UIButton!
    var signupTitleLabel: UILabel!
    var backButton: UIButton!
    var selectedImage: UIImage!
    
    var viewController: SignupViewController!
    
    init(frame: CGRect, controller: SignupViewController){
        super.init(frame: frame)
        setupTitleLabel()
        setupFullNameField()
        setupUsernameField()
        setupEmailField()
        setupPasswordField()
        setupImagePicker()
        setupSignupButton()
        setupBackButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel(){
        signupTitleLabel = UILabel(frame: CGRect(x: 30, y: 30, width: self.frame.width - 60, height: 80))
        signupTitleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        signupTitleLabel.text = "Sign Up"
        signupTitleLabel.textColor = .white
        signupTitleLabel.textAlignment = .center
        self.addSubview(signupTitleLabel)
    }
    
    func setupFullNameField(){
        fullNameField = YellowFloatingTextField(frame: CGRect(x: 30, y: 125, width: self.frame.width - 60, height: 40))
        fullNameField.placeholder = "Full Name"
        fullNameField.title = "Full Name"
        self.addSubview(fullNameField)
    }
    
    func setupUsernameField(){
        usernameField = YellowFloatingTextField(frame: CGRect(x: 30, y: 175, width: self.frame.width - 60, height: 40))
        usernameField.placeholder = "Username"
        usernameField.title = "Username"
        self.addSubview(usernameField)
    }
    
    func setupEmailField(){
        emailField = YellowFloatingTextField(frame: CGRect(x: 30, y: 225, width: self.frame.width - 60, height: 40))
        emailField.placeholder = "Email"
        emailField.title = "Email"
        self.addSubview(emailField)
    }
    
    func setupPasswordField(){
        passwordField = YellowFloatingTextField(frame: CGRect(x: 30, y: 275, width: self.frame.width - 60, height: 40))
        passwordField.placeholder = "Password"
        passwordField.title = "Password"
        self.addSubview(passwordField)
    }
    
    func setupImagePicker(){
        selectCameraImageButton = UIButton(frame: CGRect(x: self.frame.width/2 + 20, y: 350, width: self.frame.width/2 - 40, height: 50))
        selectCameraImageButton.setTitle("Take Picture", for: .normal)
        selectCameraImageButton.backgroundColor = .white
        selectCameraImageButton.layer.cornerRadius = 10
        selectCameraImageButton.setTitleColor(.MDBBlue, for: .normal)
        selectCameraImageButton.addTarget(self, action: #selector(selectPictureFromCamera), for: .touchUpInside)
        self.addSubview(selectCameraImageButton)
        
        selectLibraryImageButton = UIButton(frame: CGRect(x: self.frame.width/2 + 20, y: 410, width: self.frame.width/2 - 40, height: 50))
        selectLibraryImageButton.setTitle("Select Picture", for: .normal)
        selectLibraryImageButton.layer.cornerRadius = 10
        selectLibraryImageButton.backgroundColor = .white
        selectLibraryImageButton.setTitleColor(.MDBBlue, for: .normal)
        selectLibraryImageButton.addTarget(self, action: #selector(selectPictureFromLibrary), for: .touchUpInside)
        self.addSubview(selectLibraryImageButton)
        
        selectedImageView = UIImageView(frame: CGRect(x: 10, y: 350, width: self.frame.width/2 - 20, height: 130))
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.layer.cornerRadius = 10
        selectedImageView.image = #imageLiteral(resourceName: "defaultImage")
        self.addSubview(selectedImageView)
    }
    
    @objc func selectPictureFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func selectPictureFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    func setupSignupButton(){
        signUpButton = UIButton(frame: CGRect(x: self.frame.width/2 - 100, y: 500, width: 200, height: 60))
        signUpButton.setTitle("Create Account", for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(tappedCreateAccount), for: .touchUpInside)
        signUpButton.setTitleColor(.MDBBlue, for: .normal)
        self.addSubview(signUpButton)
    }
    
    func setupBackButton(){
        backButton = UIButton(frame: CGRect(x: self.frame.width/2 - 50, y: 575, width: 100, height: 60))
        backButton.setTitle("Cancel", for: .normal)
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 10
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        backButton.setTitleColor(.MDBBlue, for: .normal)
        self.addSubview(backButton)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        fullNameField.resignFirstResponder()
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @objc func tappedCreateAccount(){
        if fullNameField.hasText && usernameField.hasText && emailField.hasText && passwordField.hasText && selectedImage != nil{
            print("Creating account")
            FirebaseAuthHelper.signUp(name: fullNameField.text!, username: usernameField.text!, email: emailField.text!, password: passwordField.text!, image: selectedImage, view: viewController, withBlock: { (user) in
                self.viewController.dismiss(animated: true, completion: {
                    print("Finished creating user!")
                })
            })
        }
        else{
            print("Fields Missing")
            let alertController = UIAlertController(title: "Fields Blank", message:
                "Make sure you enter all required information.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func tappedBackButton(){
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}

extension SignupView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        selectedImageView.image = selectedImage
        viewController.dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
