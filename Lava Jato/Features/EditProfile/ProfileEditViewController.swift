//
//  ProfileEditViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 03/03/22.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var changeServicesButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
        
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        self.hideKeyboardWhenTappedAround()
        
        self.nameTextField.delegate = self
        self.numberTextField.delegate = self
        self.emailTextField.delegate = self
        self.dateTextField.delegate = self
        
        
        self.nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.numberTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.dateTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        self.nameTextField.layer.borderWidth = 2.0
        self.numberTextField.layer.borderWidth = 2.0
        self.emailTextField.layer.borderWidth = 2.0
        self.dateTextField.layer.borderWidth = 2.0
        
        self.nameTextField.layer.cornerRadius = 5.0
        self.numberTextField.layer.cornerRadius = 5.0
        self.emailTextField.layer.cornerRadius = 5.0
        self.dateTextField.layer.cornerRadius = 5.0
                
        self.createDatePicker()
    }
    
    func createToolbar () -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }
    
    public func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.set18YearValidation()
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = createToolbar()
    }
        @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        let alert: UIAlertController = UIAlertController(title: "Concluido", message: "Suas alteracoes foram salvas", preferredStyle: .alert)
        let confirmButton: UIAlertAction = UIAlertAction(title: "Confirmar", style: .cancel){
            (action) in
        }
        alert.addAction(confirmButton)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func tappedChangePassword(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ChangePasswordViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    @IBAction func tappedChangeService(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "meusServicos", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "meusServicos")
        navigationController?.pushViewController(vC, animated: true)
    }

    @IBAction func nameAct(_ sender: Any) {
        let text = self.nameTextField.text ?? ""
        if text.isValidName() {
            self.nameTextField.textColor = UIColor.black
        } else {
            self.nameTextField.textColor = UIColor.red
        }
    }
    
    @IBAction func phoneAct(_ sender: Any) {
        let text = self.numberTextField.text ?? ""
        if text.filterPhoneNumber().isValidPhone() {
            self.numberTextField.textColor = UIColor.black
        } else {
            self.numberTextField.textColor = UIColor.red
        }
    }
    
    
    @IBAction func emailAct(_ sender: Any) {
        let text = self.emailTextField.text ?? ""
        if text.isValidEmail() {
            self.emailTextField.textColor = UIColor.black
        } else {
            self.emailTextField.textColor = UIColor.red
        }
    }
    
    
}
extension ProfileEditViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 2.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameTextField{
            if self.nameTextField.text == ""{
                self.nameTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.nameTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.numberTextField{
            if self.numberTextField.text == ""{
                self.numberTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.numberTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.emailTextField{
            if self.emailTextField.text == ""{
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.dateTextField{
            if self.dateTextField.text == ""{
                self.dateTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.dateTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        
        if self.nameTextField.text != "" && self.emailTextField.text != "" && self.numberTextField.text != "" && self.dateTextField.text != "" && self.nameTextField.textColor == UIColor.black && self.emailTextField.textColor == UIColor.black && self.numberTextField.textColor == UIColor.black{
            self.saveButton.isHidden = false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    
    }
}
