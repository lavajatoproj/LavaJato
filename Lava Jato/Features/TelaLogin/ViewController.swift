//
//  ViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 04/02/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var btRegister: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
       
    }
    
    @IBAction func showResetPassword(_ sender: Any) {
        performSegue(withIdentifier: "password", sender: nil)
    }
    
    @IBAction func Login(_ sender: Any) {
        self.performSegue(withIdentifier: "telaPrincipal", sender: nil)
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "screenRegisterSegue", sender: nil)
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
