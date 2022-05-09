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
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var label:UILabel!
    @IBOutlet weak var selectStatusButton: UIButton!
    @IBOutlet weak var selectGenderButton:UIButton!
    
    let statusDropDown = DropDown()
    let genderDropDown = DropDown()
    var selectedButton = UIButton()
    let datePicker = UIDatePicker()
    var checkboxFlag = false
    private var viewModelScreenRegister:ViewModelScreenRegister = ViewModelScreenRegister()
    var text = "" {
        didSet {
            let success = BooleanValidator().validate(cpf: text)
            label?.text = success ? "CPF Válido" : "CPF Inválido"
        }
    }
    var text2 = "" {
        didSet {
            let success2 = BooleanValidator().validate(cnpj: text2)
            label?.text = success2 ? "CNPJ Válido" : "CNPJ Inválido"
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        self.hideKeyboardWhenTappedAround()
        self.configTextField()
        self.createDatePicker()
    }
    
    func configTextField(){
        self.nameRegisterTextField.delegate = self
        self.emailRegisterTextField.delegate = self
        self.numberRegisterTextField.delegate = self
        self.dateRegisterTextField.delegate = self
        self.documentRegisterTextField.delegate = self
        self.registerButton.isEnabled = false
        self.nameRegisterTextField.layer.borderWidth = 2.0
        self.emailRegisterTextField.layer.borderWidth = 2.0
        self.numberRegisterTextField.layer.borderWidth = 2.0
        self.dateRegisterTextField.layer.borderWidth = 2.0
        self.documentRegisterTextField.layer.borderWidth = 2.0
        self.nameRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.emailRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.numberRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.dateRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.documentRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.nameRegisterTextField.layer.cornerRadius = 5.0
        self.emailRegisterTextField.layer.cornerRadius = 5.0
        self.numberRegisterTextField.layer.cornerRadius = 5.0
        self.dateRegisterTextField.layer.cornerRadius = 5.0
        self.documentRegisterTextField.layer.cornerRadius = 5.0
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
    
    public func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.set18YearValidation()
        dateRegisterTextField.inputView = datePicker
        dateRegisterTextField.inputAccessoryView = createToolbar()
    }

    @IBAction func tappedCheckBox(_ sender: UIButton) {
        
        if (checkboxFlag == false){
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            checkboxFlag = true
            
        }else{
            sender.setBackgroundImage(UIImage(named: "checkbox1"), for: UIControl.State.normal)
            checkboxFlag = false
        }
        if self.checkboxFlag == true {
            if self.nameRegisterTextField.textColor != UIColor.red && self.numberRegisterTextField.textColor != UIColor.red && self.dateRegisterTextField.textColor != UIColor.red && self.documentRegisterTextField.textColor != UIColor.red && self.nameRegisterTextField.text != "" && self.numberRegisterTextField.text != "" && self.dateRegisterTextField.text != "" && self.documentRegisterTextField.text != "" && self.selectGenderButton.titleLabel?.text != "" && self.emailRegisterTextField.text != ""{
                self.registerButton.isEnabled = true
            }else{
                self.registerButton.isEnabled = false
            }
        }else{
            self.registerButton.isEnabled = false
        }
    }
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        performSegue(withIdentifier: "tappedRegisterSegue", sender: nil)
    }
    
    @IBAction func tappedBackLogin(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
    func setupSelectStatus(){
        statusDropDown.anchorView = selectStatusButton
        statusDropDown.bottomOffset = CGPoint(x: 0, y: selectStatusButton.bounds.height)
        selectStatusButton.setTitle("Selecione", for: .normal)
        statusDropDown.dataSource = ["Solteiro(a)", "Casado(a)", "Viuvo(a)"]
        statusDropDown.selectionAction = { [weak self] (index, item) in
            self?.selectStatusButton.setTitle(item, for: .normal)
        }
        if self.selectStatusButton.titleLabel?.text == "Selecione"{
            self.selectStatusButton.titleLabel?.textColor = UIColor.red
        }else{
            self.selectStatusButton.titleLabel?.textColor = UIColor.black
        }
    }
    func setupSelectGender(){
        genderDropDown.anchorView = selectGenderButton
        genderDropDown.bottomOffset = CGPoint(x: 0, y: selectGenderButton.bounds.height)
        selectGenderButton.setTitle("Selecione", for: .normal)
        genderDropDown.dataSource = ["Masculino", "Feminino"]
        genderDropDown.selectionAction = { [weak self] (index, item) in
            self?.selectGenderButton.setTitle(item, for: .normal)
        }
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
    
    @IBAction func tappedTermsOfUse(_ sender: UIButton) {
        if let url = URL(string: "https://modeloinicial.com.br/conteudo/termos-de-uso-e-privacidade") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func tappedSelectStatus(){
        self.setupSelectStatus()
        statusDropDown.show()
    }
    
    @IBAction func tappedSelectGender(){
        self.setupSelectGender()
        genderDropDown.show()
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
        let textCount = documentRegisterTextField.text?.count ?? 0
        if textCount <= 11{
            text = self.documentRegisterTextField?.text ?? ""
            if self.label.text == "CPF Inválido"{
                self.label.textColor = UIColor.red
                self.documentRegisterTextField.textColor = UIColor.red
            }else if self.label.text == "CPF Válido"{
                self.label.textColor = .clear
                self.documentRegisterTextField.textColor = UIColor.black
            }
        }else if textCount >= 12{
            text2 = self.documentRegisterTextField?.text ?? ""
            if self.label.text == "CNPJ Inválido"{
                self.label.textColor = UIColor.red
                self.documentRegisterTextField.textColor = UIColor.red
            }else if self.label.text == "CNPJ Válido"{
                self.label.textColor = .clear
                self.documentRegisterTextField.textColor = UIColor.black
            }
        }
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
        if self.nameRegisterTextField.text != "" && self.numberRegisterTextField.text != "" && self.dateRegisterTextField.text != "" && self.documentRegisterTextField.text != "" &&  self.selectGenderButton.titleLabel?.text != "Selecione" && self.selectStatusButton.titleLabel?.text != "Selecione o sexo" && self.emailRegisterTextField.text != "" && self.checkboxFlag == true && self.nameRegisterTextField.textColor == UIColor.black && self.emailRegisterTextField.textColor == UIColor.black && self.numberRegisterTextField.textColor == UIColor.black && self.documentRegisterTextField.textColor == UIColor.black {
            self.registerButton.isEnabled = true
        }else{
            self.registerButton.isEnabled = false
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
