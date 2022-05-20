//
//  registerViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 03/03/22.
//

import UIKit
import CPF_CNPJ_Validator
import DropDown

class ScreenRegisterViewController: UIViewController {
    @IBOutlet weak var nameRegisterTextField: UITextField!
    @IBOutlet weak var emailRegisterTextField: UITextField!
    @IBOutlet weak var numberRegisterTextField: UITextField!
    @IBOutlet weak var dateRegisterTextField: UITextField!
    @IBOutlet weak var documentRegisterTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var statesButton: UIButton!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var label:UILabel!
    @IBOutlet weak var selectStatusButton: UIButton!
    @IBOutlet weak var selectGenderButton:UIButton!
    @IBOutlet weak var switchButton: UISwitch!
    let datePicker = UIDatePicker()
    var checkboxFlag = false
    private var viewModelScreenRegister:ViewModelScreenRegister = ViewModelScreenRegister()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        self.hideKeyboard()
        self.configTextField()
        self.createDatePicker()
        self.registerButton.isEnabled = false
    }
    
    func configTextField(){
        self.nameRegisterTextField.delegate = self
        self.emailRegisterTextField.delegate = self
        self.numberRegisterTextField.delegate = self
        self.dateRegisterTextField.delegate = self
        self.documentRegisterTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.passwordTextField.isSecureTextEntry = true
        self.confirmPasswordTextField.isSecureTextEntry = true
        self.viewModelScreenRegister.textFieldStyle(textField: self.nameRegisterTextField)
        self.viewModelScreenRegister.textFieldStyle(textField: self.emailRegisterTextField)
        self.viewModelScreenRegister.textFieldStyle(textField: self.numberRegisterTextField)
        self.viewModelScreenRegister.textFieldStyle(textField: self.dateRegisterTextField)
        self.viewModelScreenRegister.textFieldStyle(textField: self.documentRegisterTextField)
        self.viewModelScreenRegister.textFieldStyle(textField: self.passwordTextField)
        self.viewModelScreenRegister.textFieldStyle(textField: self.confirmPasswordTextField)
    }
    func setButtonColor(){
        if self.selectGenderButton.titleLabel?.text == "Selecione"{
            self.selectGenderButton.titleLabel?.textColor = UIColor.red
        }
        if self.selectStatusButton.titleLabel?.text == "Selecione"{
            self.selectStatusButton.titleLabel?.textColor = UIColor.red
        }
        if self.statesButton.titleLabel?.text == "Selecione"{
            self.statesButton.titleLabel?.textColor = UIColor.red
        }
        
    }
    func getUserDefaults(key: String)-> Any?{
        return UserDefaults.standard.object(forKey: key)
    }
    
    func saveUserDefaults(value: Any, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    public func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.set18YearValidation()
        dateRegisterTextField.inputView = datePicker
        dateRegisterTextField.inputAccessoryView = createToolbar()
    }
    func createToolbar () -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.dateRegisterTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func tappedCheckBox(_ sender: UIButton) {
        if (checkboxFlag == false){
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            checkboxFlag = true
        }else{
            sender.setBackgroundImage(UIImage(named: "checkbox1"), for: UIControl.State.normal)
            checkboxFlag = false
        }
        self.validationCheckBox()
    }
    
    func validationCheckBox(){
        if self.checkboxFlag == true {
            if self.nameRegisterTextField.textColor != UIColor.red && self.numberRegisterTextField.textColor != UIColor.red && self.dateRegisterTextField.textColor != UIColor.red && self.documentRegisterTextField.textColor != UIColor.red && self.passwordTextField.textColor != UIColor.red && self.confirmPasswordTextField.textColor != UIColor.red && self.nameRegisterTextField.text != "" && self.numberRegisterTextField.text != "" && self.passwordTextField.text != "" && self.confirmPasswordTextField.text != "" && self.dateRegisterTextField.text != "" && self.documentRegisterTextField.text != "" && self.selectGenderButton.titleLabel?.text != "Selecione" && self.emailRegisterTextField.text != "" && self.selectStatusButton.titleLabel?.text != "Selecione" && self.statesButton.titleLabel?.text != "Selecione" && self.passwordValidationLabel.text != "Senhas não conferem" && self.passwordValidationLabel.text != "Minimo 6 caracteres"{
                self.registerButton.isEnabled = true
            }else{
                self.registerButton.isEnabled = false
                self.setButtonColor()
            }
        }else{
            self.registerButton.isEnabled = false
            self.setButtonColor()
        }
        
    }
    
    func equalPassword(){
        if self.passwordTextField.text != self.confirmPasswordTextField.text{
            self.passwordTextField.textColor = UIColor.red
            self.confirmPasswordTextField.textColor = UIColor.red
            self.passwordValidationLabel.textColor = UIColor.red
            self.passwordValidationLabel.text = "Senhas não conferem"
        }else{
            self.passwordTextField.textColor = UIColor.black
            self.confirmPasswordTextField.textColor = UIColor.black
            self.passwordValidationLabel.text = "Senhas conferem"
            self.passwordValidationLabel.textColor = .clear
        }
    }
    
    func validations(){
        if self.nameRegisterTextField.textColor == UIColor.red || self.numberRegisterTextField.textColor == UIColor.red || self.dateRegisterTextField.textColor == UIColor.red || self.documentRegisterTextField.textColor == UIColor.red || self.passwordTextField.textColor == UIColor.red || self.nameRegisterTextField.text == "" || self.confirmPasswordTextField.textColor == UIColor.red || self.numberRegisterTextField.text == "" || self.passwordTextField.text == "" || self.confirmPasswordTextField.text == "" || self.dateRegisterTextField.text == "" || self.documentRegisterTextField.text == "" || self.selectGenderButton.titleLabel?.text == "Selecione" || self.emailRegisterTextField.text == "" || self.selectStatusButton.titleLabel?.text == "Selecione" || self.statesButton.titleLabel?.text == "Selecione" && self.checkboxFlag == true && self.passwordValidationLabel.text == "Senhas não conferem" && self.passwordValidationLabel.text != "Minimo 6 caracteres"{
            self.registerButton.isEnabled = false
        }else{
            self.registerButton.isEnabled = true
        }
    }
    
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        performSegue(withIdentifier: "tappedRegisterSegue", sender: nil)
        self.saveUserDefaults(value: self.statesButton.titleLabel?.text ?? "Selecione", key: "userState")
    }
    
    @IBAction func tappedBackLogin(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
    
    @IBAction func nameAct(_ sender: Any) {
        let text = self.nameRegisterTextField.text ?? ""
        if text.isValidName() {
            self.nameRegisterTextField.textColor = UIColor.black
        } else {
            self.nameRegisterTextField.textColor = UIColor.red
        }
    }
    
    @IBAction func emailAct(_ sender: Any) {
        let text = self.emailRegisterTextField.text ?? ""
        if text.isValidEmail() {
            self.emailRegisterTextField.textColor = UIColor.black
        } else {
            self.emailRegisterTextField.textColor = UIColor.red
        }
    }
    
    @IBAction func passwordValidate2(_ sender: Any) {
        let password1 = self.passwordTextField.text ?? ""
        if password1.isValidPassword(){
            self.passwordTextField.textColor = UIColor.black
            self.passwordValidationLabel.text = "Senha válida"
            self.passwordValidationLabel.textColor = .clear
            self.equalPassword()
        }else{
            self.passwordTextField.textColor = UIColor.red
            self.passwordValidationLabel.text = "Minimo 6 caracteres"
            self.passwordValidationLabel.textColor = UIColor.red
        }
    }
    @IBAction func passwordValidate(_ sender: Any) {
        
        let password1 = self.confirmPasswordTextField.text ?? ""
        if password1.isValidPassword(){
            self.confirmPasswordTextField.textColor = UIColor.black
            self.passwordValidationLabel.text = "Senha válida"
            self.passwordValidationLabel.textColor = .clear
            self.equalPassword()
        }else{
            self.confirmPasswordTextField.textColor = UIColor.red
            self.passwordValidationLabel.text = "Minimo 6 caracteres"
            self.passwordValidationLabel.textColor = UIColor.red
        }
    }
    
    
    
    @IBAction func tappedTermsOfUse(_ sender: UIButton) {
        if let url = URL(string: "https://modeloinicial.com.br/conteudo/termos-de-uso-e-privacidade") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func tappedSelectStatus(){
        self.viewModelScreenRegister.createDropDownStatus(button: selectStatusButton)
    }
    
    @IBAction func tappedSelectGender(){
        self.viewModelScreenRegister.createDropDownGender(button: selectGenderButton)
    }
    
    @IBAction func tappedSelectState(_ sender: UIButton) {
        self.viewModelScreenRegister.createDropDownState(button: statesButton)
    }
    
    
    @IBAction func phoneAct(_ sender: Any) {
        let text = self.numberRegisterTextField.text ?? ""
        if text.filterPhoneNumber().isValidPhone() {
            self.numberRegisterTextField.textColor = UIColor.black
        } else {
            self.numberRegisterTextField.textColor = UIColor.red
        }
    }
    
    @IBAction func cpfValidate(_ sender: UITextField) {
        self.viewModelScreenRegister.validateCPF(textField: self.documentRegisterTextField, label: self.label)
    }
    
}

extension ScreenRegisterViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 2.0
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameRegisterTextField{
            if self.nameRegisterTextField.text == ""{
                self.nameRegisterTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.nameRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.numberRegisterTextField{
            if self.numberRegisterTextField.text == ""{
                self.numberRegisterTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.numberRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.dateRegisterTextField{
            if self.dateRegisterTextField.text == ""{
                self.dateRegisterTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.dateRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.documentRegisterTextField{
            if self.documentRegisterTextField.text == ""{
                self.documentRegisterTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.documentRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.emailRegisterTextField{
            if self.emailRegisterTextField.text == ""{
                self.emailRegisterTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.emailRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.passwordTextField{
            if self.passwordTextField.text == ""{
                self.passwordTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.confirmPasswordTextField{
            if self.confirmPasswordTextField.text == ""{
                self.confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.confirmPasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cpfValidate(documentRegisterTextField)
        self.validations()
        self.setButtonColor()
        self.validationCheckBox()
        textField.resignFirstResponder()
        return true
    }
}
extension ScreenRegisterViewController {
    public func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.validations()
        self.validationCheckBox()
        view.endEditing(true)
    }
    
    public func dismissAll() {
        DispatchQueue.main.async {
            for textField in self.view.subviews where textField is UITextField {
                textField.resignFirstResponder()
                
            }
        }
    }
    
}

