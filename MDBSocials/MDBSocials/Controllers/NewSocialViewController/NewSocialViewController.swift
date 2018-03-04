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
    
    var mainView: NewSocialView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        mainView = NewSocialView(frame: view.frame, controller: self)
        view.addSubview(mainView)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        mainView.eventNameField.resignFirstResponder()
        mainView.eventDescriptionField.resignFirstResponder()
    }
}

