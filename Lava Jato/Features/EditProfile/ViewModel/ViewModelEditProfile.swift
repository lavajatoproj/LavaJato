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
    
    public func textFieldStyle(textField:UITextField){
//        textField.layer.borderWidth = 2.0
//        textField.layer.borderColor = UIColor.lightGray.cgColor
//        textField.layer.cornerRadius = 5.0
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.ColorDefault.cgColor
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    public func selectButtonStyle(button:UIButton){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: button.frame.height - 2, width: button.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.ColorDefault.cgColor
        button.backgroundColor = .clear
        button.layer.addSublayer(bottomLine)
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
    
    public func createDropDownState(button:UIButton){
        stateDropDown.anchorView = button
        stateDropDown.bottomOffset = CGPoint(x: 0, y: button.bounds.height)
        stateDropDown.dataSource = ["Acre", "Alagoas", "Amapá", "Amazonas", "Bahia", "Ceara", "Distrito Federal", "Espírito Santo", "Goiás","Maranhão","Mato Grosso", "Mato Grosso do Sul", "Minas Gerais", "Pará", "Paraíba", "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro","Rio Grande do Norte","Rio Grande do Sul", "Rondônia", "Roraima", "Santa Catarina", "São Paulo", "Sergipe", "Tocantins"]
        stateDropDown.selectionAction = { (index, item) in
            button.setTitle(item, for: .normal)
//            self.saveUserDefaults(value: button.titleLabel?.text ?? "", key: "userState")
        }
        stateDropDown.show()
    }
    
}

