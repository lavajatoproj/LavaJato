//
//  ViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 04/02/22.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController{
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var btRegister: UIButton!
    @IBOutlet weak var btLoginGoogle: UIButton!
    
    var auth: Auth?
    
    func loginControl(){
        auth?.addStateDidChangeListener({ autentication, user in
            if user != nil {
                self.performSegue(withIdentifier: "telaPrincipalsegue", sender: nil)
            }else{
                print("O usuário não está logado")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth = Auth.auth()
        self.setupLayout()
    }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        do {
            try auth?.signOut()
        } catch {
            print("Erro ao deslogar usuário!")
        }
    }
    
    @IBAction func showResetPassword(_ sender: Any) {
        self.performSegue(withIdentifier: "RecuperarSenha", sender: nil)
    }
    
    @IBAction func Login(_ sender: Any) {
        
        if let email = tfEmail.text{
            if let password = tfPassword.text{
                
                auth?.signIn(withEmail: email, password: password) { (user,error) in
                    if error == nil{
                        print("Sucesso ao logar usuário")
                        self.performSegue(withIdentifier: "telaPrincipalsegue", sender: nil)
                    }else{
                        print("Erro ao logar usuário")
                    }
                }
            }else{
                print("error")
            }
        }else{
            print("O email e a senha não correspondem")
        }
  
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "screenRegisterSegue", sender: nil)
    }
    
    @IBAction func btGoogle(_ sender: Any) {
        let signInConfig = GIDConfiguration.init(clientID: "152072972170-kofmt4judceejf77qocrujucbs98s2m4.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in guard error == nil else { return }
            self.performSegue(withIdentifier: "telaPrincipalsegue", sender: nil)
        }
    }
    
    @IBAction func btFaceLogin(_ sender: Any) {
        
       
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
        let imageHide = UIImage(named: "eye-off.png")
        imageToHide.image = imageHide
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
}
