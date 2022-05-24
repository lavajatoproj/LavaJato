//
//  ProfileEditViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 03/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import FirebaseStorageUI

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
    @IBOutlet weak var stateButton: UIButton!
    
    private var viewModelEditProfile:ViewModelEditProfile = ViewModelEditProfile()
    private var alert:AlertController?
    var imagePicker = UIImagePickerController()
    let datePicker = UIDatePicker()
    var valueStateButton:String?
    var storage: Storage?
    var firestore: Firestore?
    var auth: Auth?
    var users: [Dictionary<String, Any>] = []
    var posts: [Dictionary<String, Any>] = []
    var idUserLog: String?
    
//    oi
    func getProfileData(){
        let user = self.firestore?.collection("users").document(self.idUserLog ?? "")
        user?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                let dataName = data?["name"]
                self.nameLabel.text = dataName as? String
                self.nameTextField.text = dataName as? String
                let dataNumber = data?["cellNumber"]
                self.numberTextField.text = dataNumber as? String
                let dataEmail = data?["email"]
                self.emailTextField.text = dataEmail as? String
                let dataCity = data?["city"]
                self.stateButton.titleLabel?.text = dataCity as? String
                let dataBorn = data?["born"]
                self.dateTextField.text = dataBorn as? String
//                if let url = data?["url"] as? String{
//                    self.profileImageView.sd_setImage(with: URL(string: url), completed: nil)
//                }else{
//                    self.profileImageView.image = UIImage(systemName: "person.circle.fill")
//                }
                }
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        Style()
        self.hideKeyboardWhenTappedAround()
        self.createDatePicker()
        self.configTextField()
        self.configPhotoPicker()
        self.setPlaceHolders()
        self.alert = AlertController(controller: self)
        self.stateButtonConfig()
        self.activeSaveButton()
        self.configButton()
        if let idUser = auth?.currentUser?.uid{
            self.idUserLog = idUser
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getProfileData()
    }
    
    func saveUserDefaults(value: Any, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    func getUserDefaults(key: String)-> Any?{
        return UserDefaults.standard.object(forKey: key)
    }
    func enableSaveButton(){
        self.saveButton.isEnabled = true
        self.saveButton.alpha = 1.0
    }
    func disableSaveButton(){
        self.saveButton.isEnabled = false
        self.saveButton.alpha = 0.0
    }
    func stateButtonConfig(){
        if self.stateButton.titleLabel?.text == "Selecione"{
            self.stateButton.titleLabel?.textColor = UIColor.red
        }
    }
    func configTextField(){
        self.nameTextField.delegate = self
        self.numberTextField.delegate = self
        self.emailTextField.delegate = self
        self.dateTextField.delegate = self
        self.viewModelEditProfile.textfieldStyle(textField: self.nameTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.numberTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.emailTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.dateTextField, color: UIColor.ColorDefault)
    }
    
    func configButton(){
        self.viewModelEditProfile.selectButtonStyle(button: self.stateButton)
    }
    
    func resetTextField(){
        self.nameTextField.text = ""
        self.numberTextField.text = ""
        self.emailTextField.text = ""
        self.dateTextField.text = ""
    }
    func setPlaceHolders(){
        self.disableSaveButton()
        self.nameTextField.placeholder = self.getUserDefaults(key: "userName") as? String
        self.numberTextField.placeholder = self.getUserDefaults(key: "userPhone") as? String
        self.emailTextField.placeholder = self.getUserDefaults(key: "userEmail") as? String
        self.dateTextField.placeholder = self.getUserDefaults(key: "userBirthday") as? String
        self.nameLabel.text = self.getUserDefaults(key: "userName")as? String
        self.valueStateButton = self.getUserDefaults(key: "userState") as? String
        self.stateButton.setTitle(valueStateButton, for: .normal)
    }
    
    func configPhotoPicker(){
        self.imagePicker.delegate = self
    }
    
    func userDefault(){
        if self.nameTextField.text != ""{
            self.saveUserDefaults(value: self.nameTextField.text ?? "", key: "userName")
        }
        if self.numberTextField.text != ""{
            self.saveUserDefaults(value: self.numberTextField.text ?? "", key: "userPhone")
        }
        if self.emailTextField.text != ""{
            self.saveUserDefaults(value: self.emailTextField.text ?? "", key: "userEmail")
        }
        if self.dateTextField.text != ""{
            self.saveUserDefaults(value: self.dateTextField.text ?? "", key: "userBirthday")
        }
        self.saveUserDefaults(value: self.stateButton.titleLabel?.text ?? "Selecione", key: "userState")
    }
    
    func activeSaveButton(){
        if self.nameTextField.placeholder != "" && self.emailTextField.placeholder != "" && self.numberTextField.placeholder != "" && self.dateTextField.placeholder != "" && self.stateButton.titleLabel?.text != "Selecione" && self.nameTextField.textColor != UIColor.red && self.emailTextField.textColor != UIColor.red && self.numberTextField.textColor != UIColor.red && self.stateButton.titleLabel?.textColor != UIColor.red && self.nameTextField.text != "" || self.emailTextField.text != "" || self.dateTextField.text != ""{
            self.enableSaveButton()
        }else{
            self.disableSaveButton()
        }
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
        self.activeSaveButton()
    }
    
    @IBAction func tappedStateButton(_ sender: UIButton) {
        self.viewModelEditProfile.createDropDownState(button: stateButton)
    }
    
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
//        self.alert?.showAlert(title: "Atenção!", message: "Salvar as alterações realizadas?", titleButton: "Salvar", completion: { value in
//            self.activeSaveButton()
//        })
        
        if let name = self.nameTextField.text, let email = self.emailTextField.text, let cellNumber = self.numberTextField.text, let born = self.dateTextField.text, let city = self.stateButton.titleLabel?.text{
            self.firestore?.collection("users").document( self.idUserLog ?? "" )
                                    .setData([
                                        "name": name,
                                        "email": email,
                                        "cellNumber": cellNumber,
                                        "born": born,
                                        "city": city,
//                                        "profileImage": url,
                                        "id": self.idUserLog as Any,
                                    ])
        }else{
            print("Error")
        }
        
        self.userDefault()
        self.setPlaceHolders()
        self.resetTextField()
    }
    
    @IBAction func tappedChangePassword(_ sender: UIButton) {
        self.viewModelEditProfile.instantiateVC(nameVC: "ChangePasswordViewController", navigation: navigationController ?? UINavigationController())
    }
    
    @IBAction func tappedChangeService(_ sender: UIButton) {
        self.viewModelEditProfile.instantiateVC(nameVC: "myServices", navigation: navigationController ?? UINavigationController())
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
        self.imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ProfileEditViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewModelEditProfile.textfieldStyle(textField: textField, color: UIColor.blue)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            self.viewModelEditProfile.textfieldStyle(textField: textField, color: UIColor.red)
        }else{
            self.viewModelEditProfile.textfieldStyle(textField: textField, color: UIColor.ColorDefault)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.activeSaveButton()
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
            self.profileImageView.contentMode = .scaleAspectFill
            self.profileImageView.image = pickedImage
            self.viewModelEditProfile.cornerRadius(image: profileImageView)
            self.profileImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
