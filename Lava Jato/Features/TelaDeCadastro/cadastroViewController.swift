//
//  registerViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 03/03/22.
//

import UIKit

class CellClass: UITableViewCell {
    
}

class cadastroViewController: UIViewController {
    
    
    @IBOutlet weak var nameRegisterTextField: UITextField!
    @IBOutlet weak var emailRegisterTextField: UITextField!
    @IBOutlet weak var numberRegisterTextField: UITextField!
    @IBOutlet weak var dateRegisterTextField: UITextField!
    @IBOutlet weak var documentRegisterTextField: UITextField!
    @IBOutlet weak var estadoCivilRegisterTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    //botao para selecionar o sexo
    @IBOutlet weak var btnSelectGender: UIButton!    
    //configuracoes dropdown
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var dataSource = [String]()
    /////////////////////////////
    let datePicker = UIDatePicker()
    
    var checkboxFlag = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        self.hideKeyboardWhenTappedAround()
        
        // Assinaturas relacionadas ao dropdown
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        self.btnSelectGender.titleLabel?.textAlignment = .left
   self.btnSelectGender.layer.cornerRadius = 5.0
        
        //////////////////////////
        //assinatura dos textfields
        self.nameRegisterTextField.delegate = self
        self.emailRegisterTextField.delegate = self
        self.numberRegisterTextField.delegate = self
        self.dateRegisterTextField.delegate = self
        self.documentRegisterTextField.delegate = self
        self.estadoCivilRegisterTextField.delegate = self
        
        //desativando botão "Cadastrar"
        self.registerButton.isEnabled = false
        
        //tamanho das bordas dos textfields
        self.nameRegisterTextField.layer.borderWidth = 2.0
        self.emailRegisterTextField.layer.borderWidth = 2.0
        self.numberRegisterTextField.layer.borderWidth = 2.0
        self.dateRegisterTextField.layer.borderWidth = 2.0
        self.documentRegisterTextField.layer.borderWidth = 2.0
        self.estadoCivilRegisterTextField.layer.borderWidth = 2.0
        // cor das bordas dos textfields
        self.nameRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.emailRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.numberRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.dateRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.documentRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.estadoCivilRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        //bordas arredondadas
        self.nameRegisterTextField.layer.cornerRadius = 5.0
        self.emailRegisterTextField.layer.cornerRadius = 5.0
        self.numberRegisterTextField.layer.cornerRadius = 5.0
        self.dateRegisterTextField.layer.cornerRadius = 5.0
        self.documentRegisterTextField.layer.cornerRadius = 5.0
        self.estadoCivilRegisterTextField.layer.cornerRadius = 5.0
        
        //criacao do seletor de data
        self.createDatePicker()
    }
    
    //Criação da View do dropdown dos sexos
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
    
    /////////////////////////////////////////////////////////////////
    
    
    //barra com botao done para o datepicker
    func createToolbar () -> UIToolbar {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }
    //criacao da função após apertar o botao done do datepicker
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.dateRegisterTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    //definindo funcoes para o datepicker
    public func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.set18YearValidation()
        dateRegisterTextField.inputView = datePicker
        dateRegisterTextField.inputAccessoryView = createToolbar()
    }
    
    // Criacao da ação do botao seletor do sexo
    @IBAction func onClickSelectGender(_ sender: UIButton) {
        dataSource = ["Masculino", "Feminino"]
        selectedButton = btnSelectGender
        addTransparentView(frames: btnSelectGender.frame)
    }
    ////////////////////////////////////////////////////////////////

    //configurações do checkbox dos termos de uso
    @IBAction func tappedCheckBox(_ sender: UIButton) {
        
        if (checkboxFlag == false){
            sender.setBackgroundImage(UIImage(named: "checkbox"), for: UIControl.State.normal)
            checkboxFlag = true
            
        }else{
            sender.setBackgroundImage(UIImage(named: "checkbox1"), for: UIControl.State.normal)
            checkboxFlag = false
        }
    }
    //definindo ações para os botões
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        performSegue(withIdentifier: "tappedRegisterSegue", sender: nil)
    }
    
    @IBAction func tappedBackLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "backLoginSegue", sender: nil)
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
    
    //validação do nome completo
    @IBAction func nameAct(_ sender: Any) {
        let text = self.nameRegisterTextField.text ?? ""
        if text.isValidName() {
            self.nameRegisterTextField.textColor = UIColor.black
        } else {
            self.nameRegisterTextField.textColor = UIColor.red
        }
    }
    //validação do e-mail
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
    
    //validação do telefone
    @IBAction func phoneAct(_ sender: Any) {
        let text = self.numberRegisterTextField.text ?? ""
        if text.filterPhoneNumber().isValidPhone() {
            self.numberRegisterTextField.textColor = UIColor.black
        } else {
            self.numberRegisterTextField.textColor = UIColor.red
        }
    }
}
    
    //adicionando extensões para textfieldDelegade (validações)
    
extension cadastroViewController:UITextFieldDelegate{
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
        if textField == self.estadoCivilRegisterTextField{
            if self.estadoCivilRegisterTextField.text == ""{
                self.estadoCivilRegisterTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.estadoCivilRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if textField == self.emailRegisterTextField{
            if self.emailRegisterTextField.text == ""{
                self.emailRegisterTextField.layer.borderColor = UIColor.red.cgColor
            }else{
                self.emailRegisterTextField.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
        if self.nameRegisterTextField.text != "" && self.numberRegisterTextField.text != "" && self.dateRegisterTextField.text != "" && self.documentRegisterTextField.text != "" && self.estadoCivilRegisterTextField.text != "" && self.btnSelectGender.titleLabel?.text != "" && self.emailRegisterTextField.text != "" && self.checkboxFlag == true && self.nameRegisterTextField.textColor == UIColor.black && self.emailRegisterTextField.textColor == UIColor.black && self.numberRegisterTextField.textColor == UIColor.black{
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
// extensão tableviewdelegade para o seletor de sexo
extension cadastroViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}

// extensão tableviewdatasource para o seletor de sexo
extension cadastroViewController: UITableViewDataSource{
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
