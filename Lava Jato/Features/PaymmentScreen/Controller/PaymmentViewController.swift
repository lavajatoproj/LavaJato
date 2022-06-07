//
//  PaymmentViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 06/06/22.
//

import UIKit
import TLCustomMask

class PaymmentViewController: UIViewController {
    
    @IBOutlet weak var nameCardTextField: UITextField!
    @IBOutlet weak var numberCardTextField: UITextField!
    @IBOutlet weak var dateCardTextField: UITextField!
    @IBOutlet weak var cvvCardTextField: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var numberTF: UITextField!
    @IBOutlet weak var expirationTF: UITextField!
    @IBOutlet weak var cvvTF: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    var numberCustomMask = TLCustomMask()
    var validateCard = TLCustomMask()
    var cvvCard = TLCustomMask()
    let paymmentScreenViewModel:PaymmentScreenViewModel = PaymmentScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.configTextField()
    }
    
//    public func textfieldStyle(textField:UITextField, color:UIColor){
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
//        bottomLine.backgroundColor = color.cgColor
//        textField.backgroundColor = .clear
//        textField.borderStyle = .none
//        textField.layer.addSublayer(bottomLine)
//    }
    func configTextField(){
        self.nameCardTextField.delegate = self
        self.numberCardTextField.delegate = self
        self.dateCardTextField.delegate = self
        self.cvvCardTextField.delegate = self
        self.nameTF.delegate = self
        self.numberTF.delegate = self
        self.expirationTF.delegate = self
        self.cvvTF.delegate = self
        self.nameCardTextField.borderStyle = .none
        self.numberCardTextField.borderStyle = .none
        self.dateCardTextField.borderStyle = .none
        self.cvvCardTextField.borderStyle = .none
        self.paymmentScreenViewModel.textfieldStyle(textField: self.nameTF, color: UIColor.ColorDefault)
        self.paymmentScreenViewModel.textfieldStyle(textField: self.numberTF, color: UIColor.ColorDefault)
        self.paymmentScreenViewModel.textfieldStyle(textField: self.expirationTF, color: UIColor.ColorDefault)
        self.paymmentScreenViewModel.textfieldStyle(textField: self.cvvTF, color: UIColor.ColorDefault)
        self.paymmentScreenViewModel.disableItem(textField: .none, button: self.confirmButton, state: false)
        self.paymmentScreenViewModel.disableItem(textField: self.numberCardTextField, button: .none, state: false)
        self.paymmentScreenViewModel.disableItem(textField: self.numberCardTextField, button: .none, state: false)
        self.paymmentScreenViewModel.disableItem(textField: self.dateCardTextField, button: .none, state: false)
        self.paymmentScreenViewModel.disableItem(textField: self.cvvCardTextField, button: .none, state: false)

//        self.confirmButton.isEnabled = false
//        self.nameCardTextField.isEnabled = false
//        self.numberCardTextField.isEnabled = false
//        self.dateCardTextField.isEnabled = false
//        self.cvvCardTextField.isEnabled = false
        numberCustomMask.formattingPattern = "$$$$ $$$$ $$$$ $$$$"
        validateCard.formattingPattern = "$$/$$"
        cvvCard.formattingPattern = "$$$"
    }
    
    func alert(title:String, message:String){
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    func setCardText(){
        self.nameCardTextField.text = self.nameTF.text
        self.numberCardTextField.text = self.numberTF.text
        self.dateCardTextField.text = self.expirationTF.text
        self.cvvCardTextField.text = self.cvvTF.text
    }
    
    func validateTF(){
        if self.nameTF.text == "" || self.numberTF.text == "" || self.expirationTF.text == "" || self.cvvTF.text == "" || self.nameTF.layer.borderColor == UIColor.red.cgColor || self.numberTF.layer.borderColor == UIColor.red.cgColor || self.expirationTF.layer.borderColor == UIColor.red.cgColor || self.cvvTF.layer.borderColor == UIColor.red.cgColor {
            self.confirmButton.isEnabled = false
        }else{
            self.confirmButton.isEnabled = true
        }
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedConfirmButton(_ sender: UIButton) {
        self.alert(title: "Concluído", message: "Seu pagamento está sendo processado!")
    }
    
}
extension PaymmentViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.paymmentScreenViewModel.textfieldStyle(textField: textField, color: UIColor.blue)
        setCardText()
        self.validateTF()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            self.paymmentScreenViewModel.textfieldStyle(textField: textField, color: UIColor.red)
        }else{
            self.paymmentScreenViewModel.textfieldStyle(textField: textField, color: UIColor.ColorDefault)
        }
        self.validateTF()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTF {
            textField.resignFirstResponder()
            self.numberTF.becomeFirstResponder()
        } else if textField == self.numberTF {
            textField.resignFirstResponder()
            self.expirationTF.becomeFirstResponder()
        } else if textField == self.expirationTF {
            textField.resignFirstResponder()
            self.cvvTF.becomeFirstResponder()
        }  else{
            textField.resignFirstResponder()
        }
        textField.resignFirstResponder()
        setCardText()
        self.validateTF()
        return true
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == self.numberTF{
            self.numberTF.text = numberCustomMask.formatStringWithRange(range: range, string: string)
            return false
        }
        if textField == self.expirationTF{
            self.expirationTF.text = validateCard.formatStringWithRange(range: range, string: string)
            return false
        }
        if textField == self.cvvTF{
            self.cvvTF.text = cvvCard.formatStringWithRange(range: range, string: string)
            return false
        }
        return true
    }
}
