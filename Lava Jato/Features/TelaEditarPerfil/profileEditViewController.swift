//
//  profileEditViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 03/03/22.
//

import UIKit

class profileEditViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var changeServicesButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    //popup de alteração de senha
    class PopUpWindow: UIViewController {
        
        private let popUpWindowView = PopUpWindowView()
        
        init(title: String, text: String, buttontext: String) {
            super.init(nibName: nil, bundle: nil)
            modalTransitionStyle = .crossDissolve
            modalPresentationStyle = .overFullScreen
            
            popUpWindowView.popupTitle.text = title
            popUpWindowView.popupText.text = text
            popUpWindowView.popupButton.setTitle(buttontext, for: .normal)
            popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
            view = popUpWindowView
            
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        @objc func dismissView(){
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    //Para capturar data no textField
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
    
    //criando barra com botão done no datePicker
    func createToolbar () -> UIToolbar {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        return toolbar
    }
    
    //definindo funcoes e validacao para o datePicker
    public func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.set18YearValidation()
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = createToolbar()
    }
    
    //definindo acao apos apertar o botao done
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    //ação ao clicar no botão "Salvar"
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        var popUpWindow: PopUpWindow!
        popUpWindow = PopUpWindow(title: "Concluído", text: "Suas alterações foram salvas", buttontext: "Confirmar")
        self.present(popUpWindow, animated: true, completion: nil)
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
    
    
    //Validação do nome completo
    @IBAction func nameAct(_ sender: Any) {
        let text = self.nameTextField.text ?? ""
        if text.isValidName() {
            self.nameTextField.textColor = UIColor.black
        } else {
            self.nameTextField.textColor = UIColor.red
        }
    }
    
    //Validação do telefone
    @IBAction func phoneAct(_ sender: Any) {
        let text = self.numberTextField.text ?? ""
        if text.filterPhoneNumber().isValidPhone() {
            self.numberTextField.textColor = UIColor.black
        } else {
            self.numberTextField.textColor = UIColor.red
        }
    }
    
    
    //Validação do e-mail
    @IBAction func emailAct(_ sender: Any) {
        let text = self.emailTextField.text ?? ""
        if text.isValidEmail() {
            self.emailTextField.textColor = UIColor.black
        } else {
            self.emailTextField.textColor = UIColor.red
        }
    }
    
    
}
//extension do textfield delegate
extension profileEditViewController:UITextFieldDelegate{
    
    //textFieldDidBeginEditing = Não faz validação, apenas da foco ao teclado, ou seja, todas as funções presentes serão executadas assim que houver o clique no textfield.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 2.0
    }
    
    
    //textFieldDidEndEditing = Após a perda do foco é esperada alguma entrada, então se inicia o processo de validação.
    
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
