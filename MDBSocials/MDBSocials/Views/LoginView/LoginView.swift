//
//  LoginView.swift
//  MDBSocials
//
//  Created by Will Oakley on 3/3/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class LoginView: UIView {
   
    var emailField: YellowFloatingTextField!
    var passwordField: YellowFloatingTextField!
    var logInButton: UIButton!
    var signUpButton: UIButton!
    var logoImage: UIImageView!
    var logoLabel: UILabel!
    
    var viewController: LoginViewController!
    
    init(frame: CGRect, controller: LoginViewController){
        super.init(frame: frame)
        viewController = controller
        setupLogo()
        setupEmailField()
        setupPasswordField()
        setupLogInButton()
        setupMakeAccountButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLogo(){
        logoImage = UIImageView(frame: CGRect(x: 20, y: 20, width: self.frame.width - 40, height: 300))
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = #imageLiteral(resourceName: "whiteLogoOutline")
        self.addSubview(logoImage)
        
        logoLabel = UILabel(frame: CGRect(x: self.frame.width/2 - 40, y: 180, width: 220, height: 140))
        logoLabel.text = "SOCIALS"
        logoLabel.textColor = .white
        logoLabel.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        self.addSubview(logoLabel)
    }
    
    func setupEmailField(){
        emailField = YellowFloatingTextField(frame: CGRect(x: 30, y: 320, width: self.frame.width - 60, height: 40))
        emailField.placeholder = "Email"
        emailField.title = "Email"
        self.addSubview(emailField)
    }
    
    func setupPasswordField(){
        passwordField = YellowFloatingTextField(frame: CGRect(x: 30, y: 390, width: self.frame.width - 60, height: 40))
        passwordField.placeholder = "Password"
        passwordField.title = "Password"
        passwordField.isSecureTextEntry = true
        self.addSubview(passwordField)
    }
    
    func setupLogInButton(){
        logInButton = UIButton(frame: CGRect(x: 30, y: 500, width: self.frame.width/2 - 60, height: 60))
        logInButton.setTitle("Log In!", for: .normal)
        logInButton.backgroundColor = .white
        logInButton.layer.cornerRadius = 10
        logInButton.addTarget(self, action: #selector(tappedLogin), for: .touchUpInside)
        logInButton.setTitleColor(.MDBBlue, for: .normal)
        self.addSubview(logInButton)
    }
    
    func setupMakeAccountButton(){
        signUpButton = UIButton(frame: CGRect(x: self.frame.width/2 + 30, y: 500, width: self.frame.width/2 - 60, height: 60))
        signUpButton.setTitle("Sign Up!", for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
        signUpButton.setTitleColor(.MDBBlue, for: .normal)
        self.addSubview(signUpButton)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @objc func tappedLogin(){
        if emailField.hasText && passwordField.hasText{
            FirebaseAuthHelper.logIn(email: emailField.text!, password: passwordField.text!, view: viewController, withBlock: { (user) in
                self.viewController.dismiss(animated: true, completion: {
                    print("Successfully logged in!")
                })
            })
        }
    }
    
    @objc func tappedSignUp(){
        viewController.performSegue(withIdentifier: "showSignup", sender: self)
    }

}
