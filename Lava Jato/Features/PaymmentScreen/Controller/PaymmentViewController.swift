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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configTextField()
    }
    
    public func textfieldStyle(textField:UITextField, color:UIColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = color.cgColor
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
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
        self.textfieldStyle(textField: nameTF, color: UIColor.ColorDefault)
        self.textfieldStyle(textField: numberTF, color: UIColor.ColorDefault)
        self.textfieldStyle(textField: expirationTF, color: UIColor.ColorDefault)
        self.textfieldStyle(textField: cvvTF, color: UIColor.ColorDefault)
        self.confirmButton.isEnabled = false
        self.nameCardTextField.isEnabled = false
        self.numberCardTextField.isEnabled = false
        self.dateCardTextField.isEnabled = false
        self.cvvCardTextField.isEnabled = false
        numberCustomMask.formattingPattern = "$$$$ $$$$ $$$$ $$$$"
        validateCard.formattingPattern = "$$/$$"
        cvvCard.formattingPattern = "$$$"
    }
    
    func setCardText(){
        self.nameCardTextField.text = self.nameTF.text
        self.numberCardTextField.text = self.numberTF.text
        self.dateCardTextField.text = self.expirationTF.text
        self.cvvCardTextField.text = self.cvvTF.text
    }
    func validateTF(){
        if nameTF.text == "" || numberTF.text == "" || expirationTF.text == "" || cvvTF.text == "" {
            self.confirmButton.isEnabled = false
        }else{
            self.confirmButton.isEnabled = true
        }
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedConfirmButton(_ sender: UIButton) {
    }
    
}
extension PaymmentViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.validateTF()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setCardText()
        self.validateTF()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
