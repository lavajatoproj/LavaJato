//
//  ViewModel.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 04/05/22.
//

import UIKit
import DropDown

class ViewModelEditProfile {
    private let stateDropDown = DropDown()
    
    public func selectButtonStyle(button:UIButton){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: button.frame.height - 2, width: button.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.ColorDefault.cgColor
        button.backgroundColor = .clear
        button.layer.addSublayer(bottomLine)
    }
    
    public func textfieldStyle(textField:UITextField, color:UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = color.cgColor
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    public func cornerRadius(image:UIImageView){
        image.layer.cornerRadius = image.frame.height / 2
    }
    
    public func widthTextField(textField:UITextField, value:Double){
        textField.layer.borderWidth = value
    }
    
    public func instantiateVC(nameVC:String, navigation:UINavigationController){
        let storyboard = UIStoryboard(name: nameVC, bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: nameVC)
        navigation.pushViewController(vC, animated: true)
    }
    public func getUserDefaults(key: String)-> Any?{
        return UserDefaults.standard.object(forKey: key)
    }
    public func saveUserDefaults(value: Any, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    public func disableTextField(textField:UITextField){
        textField.isEnabled = false
        textField.textColor = UIColor.darkGray

    }
    
    public func validatePostalCode(textField:UITextField){
        let text = textField.text ?? ""
        if text.isValidPostalCode() {
            textField.textColor = UIColor.black
        } else {
            textField.textColor = UIColor.red
        }
    }
    public func validatePhone(textField:UITextField){
        let text = textField.text ?? ""
        if text.filterPhoneNumber().isValidPhone() {
            textField.textColor = UIColor.black
        } else {
            textField.textColor = UIColor.red
        }
    }
    
}

