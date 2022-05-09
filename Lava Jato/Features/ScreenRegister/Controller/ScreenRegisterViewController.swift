//
//  registerViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 03/03/22.
//

import UIKit
import CPF_CNPJ_Validator

class CellClass: UITableViewCell {
    
}

class ScreenRegisterViewController: UIViewController {
    
    
    @IBOutlet weak var nameRegisterTextField: UITextField!
    @IBOutlet weak var emailRegisterTextField: UITextField!
    @IBOutlet weak var numberRegisterTextField: UITextField!
    @IBOutlet weak var dateRegisterTextField: UITextField!
    @IBOutlet weak var documentRegisterTextField: UITextField!
    @IBOutlet weak var statusMaritalTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var btnSelectGender: UIButton!
    @IBOutlet weak var label:UILabel!
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    let datePicker = UIDatePicker()
    var checkboxFlag = false
    private var viewModelScreenRegister:ViewModelScreenRegister = ViewModelScreenRegister()
    
    var text = "" {
        didSet {
            let success = BooleanValidator().validate(cpf: text)
            label?.text = success ? "CPF Válido" : "CPF Inválido"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        self.hideKeyboardWhenTappedAround()
        self.configSelectGender()
        self.configTextField()
        self.createDatePicker()
    }
    func configSelectGender(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        self.btnSelectGender.titleLabel?.textAlignment = .left
        self.btnSelectGender.layer.cornerRadius = 5.0
    }
    
    func configTextField(){
        self.nameRegisterTextField.delegate = self
        self.emailRegisterTextField.delegate = self
        self.numberRegisterTextField.delegate = self
        self.dateRegisterTextField.delegate = self
        self.documentRegisterTextField.delegate = self
        self.statusMaritalTextField.delegate = self
        self.registerButton.isEnabled = false
        self.nameRegisterTextField.layer.borderWidth = 2.0
        self.emailRegisterTextField.layer.borderWidth = 2.0
        self.numberRegisterTextField.layer.borderWidth = 2.0
        self.dateRegisterTextField.layer.borderWidth = 2.0
        self.documentRegisterTextField.layer.borderWidth = 2.0
        self.statusMaritalTextField.layer.borderWidth = 2.0
        self.nameRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.emailRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.numberRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.dateRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.documentRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.statusMaritalTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.nameRegisterTextField.layer.cornerRadius = 5.0
        self.emailRegisterTextField.layer.cornerRadius = 5.0
        self.numberRegisterTextField.layer.cornerRadius = 5.0
        self.dateRegisterTextField.layer.cornerRadius = 5.0
        self.documentRegisterTextField.layer.cornerRadius = 5.0
        self.statusMaritalTextField.layer.cornerRadius = 5.0
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        }, completion: nil)
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
    
    @IBAction func onClickSelectGender(_ sender: UIButton) {
        dataSource = ["Masculino", "Feminino"]
        selectedButton = btnSelectGender
        addTransparentView(frames: btnSelectGender.frame)
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
            if self.nameRegisterTextField.textColor != UIColor.red && self.numberRegisterTextField.textColor != UIColor.red && self.dateRegisterTextField.textColor != UIColor.red && self.documentRegisterTextField.textColor != UIColor.red && self.statusMaritalTextField.textColor != UIColor.red && self.statusMaritalTextField.layer.borderColor != UIColor.red.cgColor && self.nameRegisterTextField.text != "" && self.numberRegisterTextField.text != "" && self.dateRegisterTextField.text != "" && self.documentRegisterTextField.text != "" && self.statusMaritalTextField.text != "" && self.btnSelectGender.titleLabel?.text != "" && self.emailRegisterTextField.text != ""{
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
        text = self.documentRegisterTextField?.text ?? ""
        if self.label.text == "CPF Inválido"{
            self.label.textColor = UIColor.red
            self.documentRegisterTextField.textColor = UIColor.red
        }else if self.label.text == "CPF Válido"{
            self.label.textColor = .clear
            self.documentRegisterTextField.textColor = UIColor.black
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
        if textField == self.statusMaritalTextField{
            if self.statusMaritalTextField.text == ""{
                self.statusMaritalTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.statusMaritalTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.emailRegisterTextField{
            if self.emailRegisterTextField.text == ""{
                self.emailRegisterTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.emailRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if self.nameRegisterTextField.text != "" && self.numberRegisterTextField.text != "" && self.dateRegisterTextField.text != "" && self.documentRegisterTextField.text != "" && self.statusMaritalTextField.text != "" && self.btnSelectGender.titleLabel?.text != "" && self.emailRegisterTextField.text != "" && self.checkboxFlag == true && self.nameRegisterTextField.textColor == UIColor.black && self.emailRegisterTextField.textColor == UIColor.black && self.numberRegisterTextField.textColor == UIColor.black && self.documentRegisterTextField.textColor == UIColor.black {
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
extension ScreenRegisterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension ScreenRegisterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
}
