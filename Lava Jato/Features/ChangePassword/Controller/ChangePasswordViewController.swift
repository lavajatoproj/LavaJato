//
//  ChangePasswordViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 21/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var btChangePassword: UIButton!
    
    var auth:Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        self.auth = Auth.auth()
        
    }
    
    func alert(title:String, message:String){
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok:UIAlertAction = UIAlertAction(title: "Aceitar", style: .cancel, handler: nil)
        
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupStyle(){
        emailTextField.layer.cornerRadius = emailTextField.bounds.size.height / 2
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.borderColor = UIColor.white.cgColor
        emailTextField.backgroundColor = UIColor.clear
        
        btChangePassword.layer.cornerRadius = btChangePassword.bounds.size.height / 2
        btChangePassword.layer.masksToBounds = true
    }
    func sendEmail(){
        auth?.sendPasswordReset(withEmail: self.emailTextField.text ?? "", completion: { error in
            if error != nil {
                self.alert(title: "Erro", message: "Erro ao enviar e-mail")
            }
            self.alert(title: "Sucesso", message: "E-mail enviado!")
            self.emailTextField.text = ""
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    @IBAction func btChangePassword(_ sender: Any) {
        self.sendEmail()
    }

}
