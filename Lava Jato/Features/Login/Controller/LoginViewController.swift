//
//  LoginViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 04/02/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController{
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var btRegister: UIButton!
    @IBOutlet weak var btLoginGoogle: UIButton!
    @IBOutlet weak var btSeePassword: UIButton!
    var seePassword = false
    var auth: Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callFuncs()
        self.tfEmail.text = "c@f.com"
        self.tfPassword.text = "cf1234"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func callFuncs(){
        self.auth = Auth.auth()
        self.setupLayout()
        hideKeyboardWhenTappedAround()
        self.configPassword()
        self.configTextField()
    }
    
    func loginControl(){
        auth?.addStateDidChangeListener({ autentication, user in
            if user != nil {
                self.performSegue(withIdentifier: "MainScreenSegue", sender: nil)
            }else{
                print("O usuário não está logado")
            }
        })
    }
    func configPassword(){
        self.tfPassword.isSecureTextEntry = true
        self.btSeePassword.setBackgroundImage(UIImage(systemName: "eye.slash"), for: UIControl.State.normal)
        
    }
    
    func configTextField(){
        self.tfPassword.delegate = self
        self.tfEmail.delegate = self
    }
    
    func alert(title:String, message:String){
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "Aceitar", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func resetTextField(){
        self.tfEmail.text = ""
        self.tfPassword.text = ""
    }
    
    func setupLayout(){
        tfEmail.layer.cornerRadius = tfEmail.bounds.size.height / 2
        tfEmail.layer.masksToBounds = true
        tfEmail.layer.borderColor = UIColor.white.cgColor
        tfEmail.layer.borderWidth = 2
        tfEmail.layer.borderColor = UIColor.white.cgColor
        tfEmail.backgroundColor = UIColor.clear
        
        tfEmail.leftViewMode = UITextField.ViewMode.always
        let imageEmail = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let image = UIImage(named: "mail.png")
        imageEmail.image = image
        let emailView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        emailView.addSubview(imageEmail)
        tfEmail.leftView = emailView
        
        tfPassword.layer.cornerRadius = tfPassword.bounds.size.height / 2
        tfPassword.layer.masksToBounds = true
        tfPassword.layer.borderColor = UIColor.white.cgColor
        tfPassword.layer.borderWidth = 2
        tfPassword.layer.borderColor = UIColor.white.cgColor
        tfPassword.backgroundColor = UIColor.clear
        
        tfPassword.leftViewMode = UITextField.ViewMode.always
        let imageKey = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let newImage = UIImage(named: "key.png")
        imageKey.image = newImage
        let keyView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        keyView.addSubview(imageKey)
        tfPassword.leftView = keyView
        
        tfPassword.rightViewMode = UITextField.ViewMode.always
        let imageToHide = UIImageView(frame: CGRect(x: -10, y: 0, width: 20, height: 20))
        let hideView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        hideView.addSubview(imageToHide)
        tfPassword.rightView = hideView
        
        btLogin.layer.cornerRadius = btLogin.bounds.size.height / 2
        btLogin.layer.masksToBounds = true
        
        btRegister.layer.cornerRadius = btRegister.bounds.size.height / 2
        btRegister.layer.masksToBounds = true
        btRegister.layer.borderColor = UIColor.white.cgColor
        btRegister.layer.borderWidth = 2
    }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        do {
            try auth?.signOut()
        } catch {
            print("Erro ao deslogar usuário!")
            self.alert(title: "Erro", message: "Erro ao deslogar usuário!")
        }
    }
    
    @IBAction func showResetPassword(_ sender: Any) {
        self.performSegue(withIdentifier: "ResetPasswordSegue", sender: nil)
    }
    
    @IBAction func Login(_ sender: Any) {
        if let email = tfEmail.text{
            if let password = tfPassword.text{
                
                auth?.signIn(withEmail: email, password: password) { (user,error) in
                    if error == nil{
                        print("Sucesso ao logar usuário")
                        self.performSegue(withIdentifier: "MainScreenSegue", sender: nil)
                        self.resetTextField()
                    }else{
                        print("Erro ao logar usuário")
                        self.alert(title: "Erro", message: "Dados inválidos")
                    }
                }
            }else{
                print("error")
                self.alert(title: "Erro", message: "Erro ao logar")
            }
        }else{
            print("Email e a senha não correspondem")
            self.alert(title: "Erro", message: "Email e senha não correspondem")
        }
        
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "screenRegisterSegue", sender: nil)
    }
    
    @IBAction func btGoogle(_ sender: Any) {
        let signInConfig = GIDConfiguration.init(clientID: "152072972170-kofmt4judceejf77qocrujucbs98s2m4.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in guard error == nil else { return }
            self.performSegue(withIdentifier: "MainScreenSegue", sender: nil)
        }
    }
    
    @IBAction func btFaceLogin(_ sender: Any) {
        
        
    }
    @IBAction func tappedShowPassword(_ sender: UIButton) {
        if (seePassword == false){
            self.tfPassword.isSecureTextEntry = true
            sender.setBackgroundImage(UIImage(systemName: "eye.slash"), for: UIControl.State.normal)
            self.seePassword = true
        }else{
            self.tfPassword.isSecureTextEntry = false
            sender.setBackgroundImage(UIImage(systemName: "eye"), for: UIControl.State.normal)
            
            seePassword = false
        }
    }
}
extension LoginViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.ColorDefault.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == ""{
            textField.layer.borderColor = UIColor.red.cgColor
        }else{
            textField.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.tfEmail {
            textField.resignFirstResponder()
            self.tfPassword.becomeFirstResponder()
        } else if textField == self.tfPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}
