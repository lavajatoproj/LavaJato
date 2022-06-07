//
//  PaymmentScreenViewModel.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 07/06/22.
//

import Foundation
import UIKit

class PaymmentScreenViewModel{
    
    public func textfieldStyle(textField:UITextField, color:UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = color.cgColor
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    public func disableItem(textField:UITextField?, button:UIButton?, state:Bool){
        textField?.isEnabled = state
        button?.isEnabled = state
    }
    
    
}
