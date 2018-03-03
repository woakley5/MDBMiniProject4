//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var mainView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .MDBBlue
        
        mainView = LoginView(frame: view.frame, controller: self)
        view.addSubview(mainView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mainView.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
}

