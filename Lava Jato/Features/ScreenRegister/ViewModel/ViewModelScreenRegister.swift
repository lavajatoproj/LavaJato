//
//  ViewModelScreenRegister.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 08/05/22.
//

import Foundation
import UIKit
import CPF_CNPJ_Validator
import DropDown

private let statusDropDown = DropDown()
private let genderDropDown = DropDown()

class ViewModelScreenRegister{
    
    private var value:String = ""
    
    public var text = "" {
        didSet {
            let success = BooleanValidator().validate(cpf: text)
            value = success ? "CPF Válido" : "CPF Inválido"
        }
    }
    public var text2 = "" {
        didSet {
            let success2 = BooleanValidator().validate(cnpj: text2)
            value = success2 ? "CNPJ Válido" : "CNPJ Inválido"
        }
    }
    
    public func validateCPF(textField:UITextField, label:UILabel){
        label.text = value
        let textCount = textField.text?.count ?? 0
        if textCount <= 11{
            text = textField.text ?? ""
            if value == "CPF Inválido"{
                label.textColor = UIColor.red
                textField.textColor = UIColor.red
            }else if value == "CPF Válido"{
                label.textColor = .clear
                textField.textColor = UIColor.black
            }
        }else if textCount >= 12{
            text2 = textField.text ?? ""
            if value == "CNPJ Inválido"{
                label.textColor = UIColor.red
                textField.textColor = UIColor.red
            }else if value == "CNPJ Válido"{
                label.textColor = .clear
                textField.textColor = UIColor.black
            }
        }
        if textCount == 0{
            label.textColor = .clear
            textField.textColor = UIColor.black
        }
    }
    public func textfieldStyle(textField:UITextField, color:UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = color.cgColor
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    public func buttonStyle(button:UIButton){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: button.frame.height - 2, width: button.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.ColorDefault.cgColor
        button.backgroundColor = .clear
        button.layer.addSublayer(bottomLine)
    }
    
    public func createDropDownGender(button:UIButton){
        genderDropDown.anchorView = button
        genderDropDown.bottomOffset = CGPoint(x: 0, y: button.bounds.height)
        genderDropDown.dataSource = ["Masculino", "Feminino", "Outros"]
        genderDropDown.selectionAction = { (index, item) in
            button.setTitle(item, for: .normal)
        }
        genderDropDown.show()
    }
    public func createDropDownStatus(button:UIButton){
        statusDropDown.anchorView = button
        statusDropDown.bottomOffset = CGPoint(x: 0, y: button.bounds.height)
        statusDropDown.dataSource = ["Solteiro(a)", "Casado(a)", "Viuvo(a)"]
        statusDropDown.selectionAction = { (index, item) in
            button.setTitle(item, for: .normal)
        }
        statusDropDown.show()
    }
    
    public func textFieldSecurity(textField:UITextField, value:Bool){
        textField.isSecureTextEntry = value
    }

    public func validatePostalCode(textField:UITextField){
        let text = textField.text ?? ""
        if text.isValidPostalCode() {
            textField.textColor = UIColor.black
        } else {
            textField.textColor = UIColor.red
        }
    }
    
    public func validateEMail(textField:UITextField){
        let text = textField.text ?? ""
        if text.isValidEmail() {
            textField.textColor = UIColor.black
        } else {
            textField.textColor = UIColor.red
        }
    }
    public func validatePhone(textField:UITextField, validation:UILabel){
        let text = textField.text ?? ""
        if text.filterPhoneNumber().isValidPhone() {
            textField.textColor = UIColor.black
            validation.textColor = UIColor.clear
        } else {
            textField.textColor = UIColor.red
            validation.textColor = UIColor.red
            validation.text = "Ex: (DD)9099-0909"
        }
    }
    public func validateBirthday(textField:UITextField){
        if textField.text == ""{
            textField.layer.borderColor = UIColor.red.cgColor
        }else{
            textField.layer.borderColor = UIColor.ColorDefault.cgColor
        }
    }
}

