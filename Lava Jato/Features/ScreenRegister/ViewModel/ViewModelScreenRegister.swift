//
//  ViewModelScreenRegister.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 08/05/22.
//

import Foundation
import UIKit
import CPF_CNPJ_Validator

class ViewModelScreenRegister{
    var isValid:String = ""

    var text = "" {
        didSet {
            let success = BooleanValidator().validate(cpf: text)
            isValid = success ? "CPF Válido" : "CPF Inválido"
        }
    }
}
extension ViewModelScreenRegister{
    @IBAction func didChange() {
        text = isValid ?? ""
//        if isValid == "CPF Válido"{
//            self.textField?.layer.borderColor = UIColor.blue.cgColor
//        }
    }
}
