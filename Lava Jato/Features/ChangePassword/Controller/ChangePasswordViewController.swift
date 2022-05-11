//
//  ChangePasswordViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 21/03/22.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    
    @IBOutlet weak var tfOldPassword: UITextField!
    @IBOutlet weak var tfNewPasssword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var btChangePassword: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btChangePassword(_ sender: Any) {
        
    }

    func setupStyle(){
        
        tfOldPassword.layer.cornerRadius = tfOldPassword.bounds.size.height / 2
        tfOldPassword.layer.masksToBounds = true
        tfOldPassword.layer.borderColor = UIColor.white.cgColor
        tfOldPassword.layer.borderWidth = 2
        tfOldPassword.layer.borderColor = UIColor.white.cgColor
        tfOldPassword.backgroundColor = UIColor.clear
        
        tfNewPasssword.layer.cornerRadius = tfNewPasssword.bounds.size.height / 2
        tfNewPasssword.layer.masksToBounds = true
        tfNewPasssword.layer.borderColor = UIColor.white.cgColor
        tfNewPasssword.layer.borderWidth = 2
        tfNewPasssword.layer.borderColor = UIColor.white.cgColor
        tfNewPasssword.backgroundColor = UIColor.clear
        
        tfConfirmPassword.layer.cornerRadius = tfConfirmPassword.bounds.size.height / 2
        tfConfirmPassword.layer.masksToBounds = true
        tfConfirmPassword.layer.borderColor = UIColor.white.cgColor
        tfConfirmPassword.layer.borderWidth = 2
        tfConfirmPassword.layer.borderColor = UIColor.white.cgColor
        tfConfirmPassword.backgroundColor = UIColor.clear
        
        btChangePassword.layer.cornerRadius = btChangePassword.bounds.size.height / 2
        btChangePassword.layer.masksToBounds = true
    }
}
