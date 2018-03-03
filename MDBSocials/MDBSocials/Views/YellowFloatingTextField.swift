//
//  YellowFloatingTextField.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/28/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class YellowFloatingTextField: SkyFloatingLabelTextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.textColor = .white
        self.placeholderColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        self.lineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        self.selectedTitleColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        self.titleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.selectedLineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        self.tintColor = .white
    }
    
    
    
}
