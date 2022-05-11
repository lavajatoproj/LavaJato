//
//  PerfilUsuarioViewController.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 07/03/22.
//

import UIKit

class UserProfileViewController: UIViewController {
    

    @IBOutlet weak var tappedMuteSwitch: UISwitch!
    @IBOutlet weak var muteImageView: UIImageView!
    @IBOutlet weak var tappedMyServiceButton: UIButton!
    @IBOutlet weak var tappedHelpButton: UIButton!
    @IBOutlet weak var tappedRecomendButton: UIButton!
    @IBOutlet weak var tappedLogoutButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func tappedMuteSwitch(_ sender: UISwitch) {
    }
    
    
    @IBAction func tappedMyServiceButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "myServices", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "myServices")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func tappedHelpButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HelpScreenViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "HelpScreenViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func tappedRecomendButton(_ sender: UIButton) {
    }
    
    @IBAction func tappedLogoutButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "Login")
        UIApplication.shared.keyWindow?.rootViewController = vC
    }
    
    @IBAction func tappedEditProfile(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ProfileEditViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "ProfileEditViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func tappedNotification(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "NotificationViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
    
   
}
