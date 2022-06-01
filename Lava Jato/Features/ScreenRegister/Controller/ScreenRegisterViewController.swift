//
//  ScreenRegisterViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 03/03/22.
//

import UIKit
import CPF_CNPJ_Validator
import DropDown
import FirebaseAuth
import FirebaseFirestore

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
    @IBOutlet weak var seePasswordButton: UIButton!
    @IBOutlet weak var switchButton: UISwitch!
    let datePicker = UIDatePicker()
    var checkboxFlag = false
    var seePassword = false
    private var viewModelScreenRegister:ViewModelScreenRegister = ViewModelScreenRegister()
    var auth: Auth?
    var firestore: Firestore?
    var serverSwitchState:Bool = true
    
    func serverSwitch(){
            if self.switchButton.isOn == true{
                self.serverSwitchState = true
            }else{
                self.serverSwitchState = false
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        self.hideKeyboard()
        self.configTextField()
        self.createDatePicker()
        self.registerButton.isEnabled = false
        self.configButton()
        self.configPassword()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }
    
    func configTextField(){
        self.nameRegisterTextField.delegate = self
        self.emailRegisterTextField.delegate = self
        self.numberRegisterTextField.delegate = self
        self.dateRegisterTextField.delegate = self
        self.documentRegisterTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.viewModelScreenRegister.textfieldStyle(textField: self.nameRegisterTextField, color: UIColor.ColorDefault)
        self.viewModelScreenRegister.textfieldStyle(textField: self.emailRegisterTextField, color: UIColor.ColorDefault)
        self.viewModelScreenRegister.textfieldStyle(textField: self.numberRegisterTextField, color: UIColor.ColorDefault)
        self.viewModelScreenRegister.textfieldStyle(textField: self.dateRegisterTextField, color: UIColor.ColorDefault)
        self.viewModelScreenRegister.textfieldStyle(textField: self.documentRegisterTextField, color: UIColor.ColorDefault)
        self.viewModelScreenRegister.textfieldStyle(textField: self.passwordTextField, color: UIColor.ColorDefault)
        self.viewModelScreenRegister.textfieldStyle(textField: self.confirmPasswordTextField, color: UIColor.ColorDefault)
    }

    func configButton(){
        self.viewModelScreenRegister.buttonStyle(button: self.selectStatusButton)
        self.viewModelScreenRegister.buttonStyle(button: self.selectGenderButton)
        self.viewModelScreenRegister.buttonStyle(button: self.statesButton)
    }
    
    func configPassword(){
        self.passwordTextField.isSecureTextEntry = true
        self.confirmPasswordTextField.isSecureTextEntry = true
        self.seePasswordButton.setBackgroundImage(UIImage(named: "eyes_off"), for: UIControl.State.normal)
    }
    
    func setButtonColor(){
        if self.selectGenderButton.titleLabel?.text == "Sexo"{
            self.selectGenderButton.titleLabel?.textColor = UIColor.red
        }
        if self.selectStatusButton.titleLabel?.text == "Estado Civil"{
            self.selectStatusButton.titleLabel?.textColor = UIColor.red
        }
        if self.statesButton.titleLabel?.text == "Cidade"{
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
    @IBAction func showPassword(_ sender: UIButton) {
        if (seePassword == false){
            self.passwordTextField.isSecureTextEntry = true
            self.confirmPasswordTextField.isSecureTextEntry = true
            sender.setBackgroundImage(UIImage(named: "eyes_off"), for: UIControl.State.normal)
            self.seePassword = true
        }else{
            self.passwordTextField.isSecureTextEntry = false
            self.confirmPasswordTextField.isSecureTextEntry = false
            sender.setBackgroundImage(UIImage(named: "eyes_on"), for: UIControl.State.normal)
            seePassword = false
        }
    }
    
    func validationCheckBox(){
        if self.checkboxFlag == true {
            if self.nameRegisterTextField.textColor != UIColor.red && self.numberRegisterTextField.textColor != UIColor.red && self.dateRegisterTextField.textColor != UIColor.red && self.documentRegisterTextField.textColor != UIColor.red && self.passwordTextField.textColor != UIColor.red && self.confirmPasswordTextField.textColor != UIColor.red && self.nameRegisterTextField.text != "" && self.numberRegisterTextField.text != "" && self.passwordTextField.text != "" && self.confirmPasswordTextField.text != "" && self.dateRegisterTextField.text != "" && self.documentRegisterTextField.text != "" && self.selectGenderButton.titleLabel?.text != "Sexo" && self.emailRegisterTextField.text != "" && self.selectStatusButton.titleLabel?.text != "Estado Civil" && self.statesButton.titleLabel?.text != "Cidade" && self.passwordValidationLabel.text != "Senhas não conferem" && self.passwordValidationLabel.text != "Minimo 6 caracteres"{
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
        if self.nameRegisterTextField.textColor == UIColor.red || self.numberRegisterTextField.textColor == UIColor.red || self.dateRegisterTextField.textColor == UIColor.red || self.documentRegisterTextField.textColor == UIColor.red || self.passwordTextField.textColor == UIColor.red || self.nameRegisterTextField.text == "" || self.confirmPasswordTextField.textColor == UIColor.red || self.numberRegisterTextField.text == "" || self.passwordTextField.text == "" || self.confirmPasswordTextField.text == "" || self.dateRegisterTextField.text == "" || self.documentRegisterTextField.text == "" || self.selectGenderButton.titleLabel?.text == "Sexo" || self.emailRegisterTextField.text == "" || self.selectStatusButton.titleLabel?.text == "Estado Civil" || self.statesButton.titleLabel?.text == "Cidade" && self.checkboxFlag == true && self.passwordValidationLabel.text == "Senhas não conferem" && self.passwordValidationLabel.text != "Minimo 6 caracteres"{
            self.registerButton.isEnabled = false
        }else{
            self.registerButton.isEnabled = true
        }
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        
        self.serverSwitch()
        
        if let name = self.nameRegisterTextField.text, let email = self.emailRegisterTextField.text, let password = self.passwordTextField.text, let cellNumber = self.numberRegisterTextField.text, let born = self.dateRegisterTextField.text, let document = self.documentRegisterTextField.text, let city = self.statesButton.titleLabel?.text, let state = self.selectStatusButton.titleLabel?.text, let gender = self.selectGenderButton.titleLabel?.text{
    
                    self.auth?.createUser(withEmail: email, password: password) { (data, error) in
                        if error == nil{
                            if let idUser = data?.user.uid{
                                self.firestore?.collection("users")
                                    .document( idUser )
                                    .setData([
                                        "name": name,
                                        "email": email,
                                        "cellNumber": cellNumber,
                                        "born": born,
                                        "document": document,
                                        "city": city,
                                        "state": state,
                                        "gender": gender,
                                        "server": self.serverSwitchState,
                                        "id": idUser,
                                    ])
                            }
                        }
                    }
            dismiss(animated: true, completion: nil)
        }else{
            print("Error")
        }
        
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
        self.viewModelScreenRegister.textfieldStyle(textField: textField, color: UIColor.blue)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            self.viewModelScreenRegister.textfieldStyle(textField: textField, color: UIColor.red)
        }else{
            self.viewModelScreenRegister.textfieldStyle(textField: textField, color: UIColor.ColorDefault)
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismiKeyboard() {
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

