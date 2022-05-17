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
private let stateDropDown = DropDown()


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
    
    public func textFieldStyle(textField:UITextField){
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5.0
    }
    
    public func createDropDownGender(button:UIButton){
        genderDropDown.anchorView = button
        genderDropDown.bottomOffset = CGPoint(x: 0, y: button.bounds.height)
        genderDropDown.dataSource = ["Masculino", "Feminino"]
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
    public func createDropDownState(button:UIButton){
        stateDropDown.anchorView = button
        stateDropDown.bottomOffset = CGPoint(x: 0, y: button.bounds.height)
        stateDropDown.dataSource = ["Acre", "Alagoas", "Amapá", "Amazonas", "Bahia", "Ceara", "Distrito Federal    ", "Espírito Santo", "Goiás","Maranhão","Mato Grosso", "Mato Grosso do Sul", "Minas Gerais", "Pará", "Paraíba", "Paraná", "Pernambuco", "Piauí", "Rio de Janeiro","Rio Grande do Norte","Rio Grande do Sul", "Rondônia", "Roraima", "Santa Catarina", "São Paulo", "Sergipe", "Tocantins"]
        stateDropDown.selectionAction = { (index, item) in
            button.setTitle(item, for: .normal)
        }
        stateDropDown.show()
    }
    
    public func boolTrue(value:Bool)-> Bool{
        return true
    }
    public func boolFalse(value:Bool)-> Bool{
        return false
    }
    
    public func validation(nameTextField:UITextField, emailTextField:UITextField, numberTextField:UITextField, documentTextField:UITextField, dateTextField:UITextField, checkBox:Bool, registerButton:UIButton, genderButton:UIButton, statusButton:UIButton, stateButton:UIButton){
        if nameTextField.text != "" && numberTextField.text != "" && dateTextField.text != "" && documentTextField.text != "" &&  genderButton.titleLabel?.text != "Selecione" && statusButton.titleLabel?.text != "Selecione" && emailTextField.text != "" && checkBox == true && nameTextField.textColor == UIColor.black && emailTextField.textColor == UIColor.black && numberTextField.textColor == UIColor.black && documentTextField.textColor == UIColor.black && stateButton.titleLabel?.text != "Selecione"{
            registerButton.isEnabled = true
        }else{
            registerButton.isEnabled = false
        }
    }
}

