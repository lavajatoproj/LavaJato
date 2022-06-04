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

class ProfileEditViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var numberAdressTextField: UITextField!
    @IBOutlet weak var changeServicesButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var profileImageView:UIImageView!
    @IBOutlet weak var editPhotoButton:UIButton!
    @IBOutlet weak var serviceImageview: UIImageView!
    
    private var viewModelEditProfile:ViewModelEditProfile = ViewModelEditProfile()
    private var alert:AlertController?
    var imagePicker = UIImagePickerController()
    var valueStateButton:String?
    var firestore = Firestore.firestore()
    let storage = Storage.storage().reference()
    var auth: Auth?
    var users: [Dictionary<String, Any>] = []
    var posts: [Dictionary<String, Any>] = []
    var idUserLog: String?
    var document:String?
    var state:String?
    var gender:String?
    var serverState:Bool?
    
    func getProfileData(){
        let user = self.firestore.collection("users").document(self.idUserLog ?? "")
        user.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                let dataName = data?["name"]
                self.nameLabel.text = dataName as? String
                self.nameTextField.text = dataName as? String
                let dataNumber = data?["cellNumber"]
                self.numberTextField.text = dataNumber as? String
                let dataEmail = data?["email"]
                self.emailTextField.text = dataEmail as? String
                let dataCity = data?["cep"]
                self.postalCodeTextField.text = dataCity as? String
                let dataAdress = data?["adress"]
                self.adressTextField.text = dataAdress as? String
                let dataAdressNumber = data?["numberAdress"]
                self.numberAdressTextField.text = dataAdressNumber as? String
                let dataBorn = data?["born"]
                self.dateTextField.text = dataBorn as? String
                self.document = data?["document"] as? String
                self.state = data?["state"] as? String
                self.gender = data?["gender"] as? String
                self.serverState = data?["server"] as? Bool
                if self.serverState == false{
                    self.changeServicesButton.isHidden = true
                    self.serviceImageview.isHidden = true
                }
                if let url = data?["profileImage"] as? String{
                    self.profileImageView.sd_setImage(with: URL(string: url), completed: nil)
                }else{
                    self.profileImageView.image = UIImage(systemName: "person.circle.fill")
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFunc()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getProfileData()
    }
    
    func getFunc(){
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
//        self.storage = Storage.storage()
        Style()
        self.hideKeyboardWhenTappedAround()
        self.configTextField()
        self.configPhotoPicker()
        self.alert = AlertController(controller: self)
        self.enableSaveButton()
        self.profileImageView.contentMode = .scaleAspectFill
        self.viewModelEditProfile.cornerRadius(image: profileImageView)
        self.profileImageView.clipsToBounds = true
        if let idUser = auth?.currentUser?.uid{
            self.idUserLog = idUser
        }
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
    
    func configTextField(){
        self.nameTextField.delegate = self
        self.numberTextField.delegate = self
        self.emailTextField.delegate = self
        self.dateTextField.delegate = self
        self.postalCodeTextField.delegate = self
        self.adressTextField.delegate = self
        self.numberAdressTextField.delegate = self
        self.viewModelEditProfile.textfieldStyle(textField: self.nameTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.numberTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.emailTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.dateTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.postalCodeTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.adressTextField, color: UIColor.ColorDefault)
        self.viewModelEditProfile.textfieldStyle(textField: self.numberAdressTextField, color: UIColor.ColorDefault)
        
        
        self.nameTextField.textColor = UIColor.darkGray
        self.emailTextField.textColor = UIColor.darkGray
        self.dateTextField.textColor = UIColor.darkGray
        self.nameTextField.isEnabled = false
        self.emailTextField.isEnabled = false
        self.dateTextField.isEnabled = false
    }
    
    func alert(title:String, message:String){
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "Aceitar", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func configPhotoPicker(){
        self.imagePicker.delegate = self
    }
    
    func activeSaveButton(){
        if self.numberTextField.text != "" && self.dateTextField.text != "" && self.postalCodeTextField.text != "" && self.numberTextField.textColor != UIColor.red && self.postalCodeTextField.textColor != UIColor.red{
            self.enableSaveButton()
        }else{
            self.disableSaveButton()
        }
    }
    
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        
        if self.numberTextField.text == "" || self.numberTextField.textColor == UIColor.red || self.postalCodeTextField.text == "" || self.postalCodeTextField.textColor == UIColor.red || self.adressTextField.text == "" || self.adressTextField.textColor == UIColor.red || self.numberAdressTextField.text == "" || self.numberAdressTextField.textColor == UIColor.red {
            self.alert(title: "Atenção", message: "Verificar campos")
            self.activeSaveButton()
        }else{
            self.saveProfileImage()
        }

    }

    func saveData(name:String, profileImage:String, email: String, cellNumber: String, born: String, document:String, cep:String, state:String, gender:String, server:Bool, adress:String, numberAdress:String){
        self.firestore.collection("users").document( self.idUserLog ?? "" )
            .setData([
            "profileImage": profileImage,
            "name": name,
            "email": email,
            "cellNumber": cellNumber,
            "born": born,
            "document": document,
            "cep": cep,
            "state": state,
            "gender": gender,
            "server": server,
            "adress": adress,
            "numberAdress": numberAdress,
            "id": idUserLog ?? "",
        ])
    }

    func saveProfileImage(){
        guard let image = self.profileImageView.image?.jpegData(compressionQuality: 0.8) else {return}

        let imagePath = "userImages/\(UUID().uuidString).jpg"
        let imageRef = storage.child(imagePath)

        imageRef.putData(image, metadata: nil) { metadata, error in

            if error == nil && metadata != nil {
                imageRef.downloadURL { url, error in
                    if error == nil{
                        if let urlImagem = url?.absoluteString{
                            self.firestore.collection("images").document().setData([
                                "url": urlImagem
                            ])
                            self.completionRegister(with: urlImagem)
                        }
                    }else{
                        self.completionRegister()
                    }
                }
            }else{
                self.completionRegister()
            }
        }
    }

    func completionRegister(with url:String = ""){
        self.saveData(name: self.nameTextField.text ?? "", profileImage: url, email: self.emailTextField.text ?? "", cellNumber: self.numberTextField.text ?? "", born: self.dateTextField.text ?? "", document: self.document ?? "", cep: self.postalCodeTextField.text ?? "", state: self.state ?? "", gender: self.gender ?? "", server: self.serverState ?? false, adress: self.adressTextField.text ?? "", numberAdress: self.numberAdressTextField.text ?? "")
    }
    
    @IBAction func tappedChangePassword(_ sender: UIButton) {
        self.viewModelEditProfile.instantiateVC(nameVC: "ChangePasswordViewController", navigation: navigationController ?? UINavigationController())
    }
    
    @IBAction func tappedChangeService(_ sender: UIButton) {
        self.viewModelEditProfile.instantiateVC(nameVC: "myServices", navigation: navigationController ?? UINavigationController())
    }
    
    
    
    @IBAction func postalCodeAct(_ sender: UITextField) {
        let text = self.postalCodeTextField.text ?? ""
        if text.isValidPostalCode() {
            self.postalCodeTextField.textColor = UIColor.black
        } else {
            self.postalCodeTextField.textColor = UIColor.red
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
