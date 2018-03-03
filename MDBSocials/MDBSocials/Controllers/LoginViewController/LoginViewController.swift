//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var emailField: YellowFloatingTextField!
    var passwordField: YellowFloatingTextField!
    var logInButton: UIButton!
    var signUpButton: UIButton!
    var logoImage: UIImageView!
    var logoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = Constants.MDBBlue
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        setupLogo()
        setupEmailField()
        setupPasswordField()
        setupLogInButton()
        setupMakeAccountButton()
    }
    
    func setupLogo(){
        logoImage = UIImageView(frame: CGRect(x: 20, y: 20, width: view.frame.width - 40, height: 300))
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = #imageLiteral(resourceName: "whiteLogoOutline")
        view.addSubview(logoImage)
        
        logoLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 40, y: 180, width: 220, height: 140))
        logoLabel.text = "SOCIALS"
        logoLabel.textColor = .white
        logoLabel.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        view.addSubview(logoLabel)
    }
    
    func setupEmailField(){
        emailField = YellowFloatingTextField(frame: CGRect(x: 30, y: 320, width: view.frame.width - 60, height: 40))
        emailField.placeholder = "Email"
        emailField.title = "Email"
        view.addSubview(emailField)
    }
    
    func setupPasswordField(){
        passwordField = YellowFloatingTextField(frame: CGRect(x: 30, y: 390, width: view.frame.width - 60, height: 40))
        passwordField.placeholder = "Password"
        passwordField.title = "Password"
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
    }
    
    func setupLogInButton(){
        logInButton = UIButton(frame: CGRect(x: 30, y: 500, width: view.frame.width/2 - 60, height: 60))
        logInButton.setTitle("Log In!", for: .normal)
        logInButton.backgroundColor = .white
        logInButton.layer.cornerRadius = 10
        logInButton.addTarget(self, action: #selector(tappedLogin), for: .touchUpInside)
        logInButton.setTitleColor(Constants.MDBBlue, for: .normal)
        view.addSubview(logInButton)
    }
    
    func setupMakeAccountButton(){
        signUpButton = UIButton(frame: CGRect(x: view.frame.width/2 + 30, y: 500, width: view.frame.width/2 - 60, height: 60))
        signUpButton.setTitle("Sign Up!", for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
        signUpButton.setTitleColor(Constants.MDBBlue, for: .normal)
        view.addSubview(signUpButton)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @objc func tappedLogin(){
        if emailField.hasText && passwordField.hasText{
            FirebaseAuthHelper.logIn(email: emailField.text!, password: passwordField.text!, view: self, withBlock: { (user) in
                self.dismiss(animated: true, completion: {
                    print("Successfully logged in!")
                })
            })
        }
    }
    
    @objc func tappedSignUp(){
        self.performSegue(withIdentifier: "showSignup", sender: self)
    }
}

