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
    @IBOutlet weak var profileImageView:UIImageView!
    @IBOutlet weak var editPhotoButton:UIButton!
    
    private var viewModelEditProfile:ViewModelEditProfile = ViewModelEditProfile()
    
    private var alert:AlertController?
    var imagePicker = UIImagePickerController()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
        self.hideKeyboardWhenTappedAround()
        self.createDatePicker()
        self.configTextField()
        self.configPhotoPicker()
        self.alert = AlertController(controller: self)
    }
    
    func saveUserDefaults(value: Any, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func configTextField(){
        self.nameTextField.delegate = self
        self.numberTextField.delegate = self
        self.emailTextField.delegate = self
        self.dateTextField.delegate = self
        self.viewModelEditProfile.textFieldStyle(textField: nameTextField)
        self.viewModelEditProfile.textFieldStyle(textField: numberTextField)
        self.viewModelEditProfile.textFieldStyle(textField: emailTextField)
        self.viewModelEditProfile.textFieldStyle(textField: dateTextField)
    }
    
    func resetTextField(){
        self.nameTextField.text = ""
        self.numberTextField.text = ""
        self.emailTextField.text = ""
        self.dateTextField.text = ""
    }
    
    func setValueTextField(){
        //        self.nameTextField.placeholder = nameTextField.text
        //        self.numberTextField.placeholder = numberTextField.text
        //        self.emailTextField.placeholder = emailTextField.text
        //        self.dateTextField.placeholder = dateTextField.text
        //        self.nameLabel.text = nameTextField.text
        self.saveButton.isEnabled = false
        self.nameTextField.placeholder = self.getUserDefaults(key: "userName")as? String
        self.numberTextField.placeholder = self.getUserDefaults(key: "userPhone")as? String
        self.emailTextField.placeholder = self.getUserDefaults(key: "userEmail")as? String
        self.dateTextField.placeholder = self.getUserDefaults(key: "userBirthday")as? String
        self.nameLabel.text = self.getUserDefaults(key: "userName")as? String
    }
    
    func configPhotoPicker(){
        self.imagePicker.delegate = self
    }
    
    func getUserDefaults(key: String)-> Any?{
        return UserDefaults.standard.object(forKey: key)
    }
    
    public func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.set18YearValidation()
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = createToolbar()
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
        self.dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        self.alert?.showAlert(title: "Concluido", message: "Suas alterações foram salvas", titleButton: "Confirmar", completion: { value in
            self.resetTextField()
        })
        self.saveUserDefaults(value: self.nameTextField.text ?? "", key: "userName")
        self.saveUserDefaults(value: self.numberTextField.text ?? "", key: "userPhone")
        self.saveUserDefaults(value: self.emailTextField.text ?? "", key: "userEmail")
        self.saveUserDefaults(value: self.dateTextField.text ?? "", key: "userBirthday")
        self.setValueTextField()
    }
    
    @IBAction func tappedChangePassword(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ChangePasswordViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    
    @IBAction func tappedChangeService(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "myServices", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "myServices")
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
    
    @IBAction func tappedEditPhoto(_ sender: UIButton) {
        self.imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
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

extension ProfileEditViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.profileImageView.contentMode = .scaleToFill
            self.profileImageView.image = pickedImage
            self.profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
            self.profileImageView.clipsToBounds = true
            
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
//extension ProfileEditViewController:ScreenRegisterControllerDelegate{
//    func refreshData() {
//        
//    }
//    
//    
//}
