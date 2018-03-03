//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    var mainView: SignupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .MDBBlue
        
        mainView = SignupView(frame: view.frame, controller: self)
        view.addSubview(mainView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mainView.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
}


