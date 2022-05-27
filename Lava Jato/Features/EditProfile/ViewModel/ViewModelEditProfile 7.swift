//
//  ViewModel.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 04/05/22.
//

import UIKit

class ViewModelEditProfile {
    
    
    func textFieldStyle(textField:UITextField){
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5.0
    }
    
    func cornerRadius(image:UIImageView){
        image.layer.cornerRadius = image.frame.height / 2
    }
    
    func widthTextField(textField:UITextField, value:Double){
        textField.layer.borderWidth = value

    }
    
    func instantiateVC(nameVC:String, navigation:UINavigationController){
        let storyboard = UIStoryboard(name: nameVC, bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: nameVC)
        navigation.pushViewController(vC, animated: true)
    }
    
}

