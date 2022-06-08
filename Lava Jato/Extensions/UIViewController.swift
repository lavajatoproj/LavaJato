//
//  UIViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 07/03/22.
//

import UIKit

extension UIViewController {
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func dismissAllKeyboard() {
        DispatchQueue.main.async {
            for textField in self.view.subviews where textField is UITextField {
                textField.resignFirstResponder()
            }
        }
    }
    
}
