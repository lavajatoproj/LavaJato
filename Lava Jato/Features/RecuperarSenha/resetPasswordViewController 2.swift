//
//  resetPasswordViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 11/02/22.
//

import UIKit

class resetPasswordViewController: UIViewController {

    
    @IBOutlet weak var tfEmailReset: UITextField!
    @IBOutlet weak var sendEmail: UIButton!
    @IBOutlet weak var changerEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
     
    }
    
    
    @IBAction func backLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
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
