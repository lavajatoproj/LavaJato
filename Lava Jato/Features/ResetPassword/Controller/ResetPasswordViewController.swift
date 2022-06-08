//
//  ResetPasswordViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 11/02/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var tfEmailReset: UITextField!
    @IBOutlet weak var sendEmail: UIButton!
    @IBOutlet weak var changerEmail: UIButton!
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
    
    @IBAction func backLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        auth?.sendPasswordReset(withEmail: self.tfEmailReset.text ?? "", completion: { error in
            if error != nil {
                self.alert(title: "Erro", message: "Erro ao enviar e-mail")
            }
            self.alert(title: "Sucesso", message: "E-mail enviado!")
            self.navigationController?.popToRootViewController(animated: true)
            self.tfEmailReset.text = ""
        })
    }
    func setupStyle(){
        
        tfEmailReset.layer.cornerRadius = tfEmailReset.bounds.size.height / 2
        tfEmailReset.layer.masksToBounds = true
        tfEmailReset.layer.borderColor = UIColor.white.cgColor
        tfEmailReset.layer.borderWidth = 2
        tfEmailReset.layer.borderColor = UIColor.white.cgColor
        tfEmailReset.backgroundColor = UIColor.clear
        
        tfEmailReset.leftViewMode = UITextField.ViewMode.always
        let imageEmail = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let image = UIImage(named: "mail.png")
        imageEmail.image = image
        let emailView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        emailView.addSubview(imageEmail)
        tfEmailReset.leftView = emailView
        
        sendEmail.layer.cornerRadius = sendEmail.bounds.size.height / 2
        sendEmail.layer.masksToBounds = true
        
        changerEmail.layer.cornerRadius = changerEmail.bounds.size.height / 2
        changerEmail.layer.masksToBounds = true
        changerEmail.layer.borderColor = UIColor.white.cgColor
        changerEmail.layer.borderWidth = 2
    }
}
