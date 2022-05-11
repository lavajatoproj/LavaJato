//
//  PerfilUsuarioViewController.swift
//  Lava Jato
//
//  Created by Olimpio Junior on 07/03/22.
//

import UIKit

class PerfilUsuarioViewController: UIViewController {

    @IBOutlet weak var tappedMuteSwitch: UISwitch!
    @IBOutlet weak var muteImageView: UIImageView!
    @IBOutlet weak var tappedMyServiceButton: UIButton!
    @IBOutlet weak var tappedHelpButton: UIButton!
    @IBOutlet weak var tappedRecomendButton: UIButton!
    @IBOutlet weak var tappedLogoutButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Style()
//        configGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func tappedMuteSwitch(_ sender: UISwitch) {
    }
    
    
    @IBAction func tappedMyServiceButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "meusServicos", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "meusServicos")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func tappedHelpButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ScreenHelp", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "ScreenHelp")
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
        let storyboard = UIStoryboard(name: "ProfileEdit", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "ProfileEdit")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func tappedNotification(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "Main")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
        
    }

    // método para configurar o Gesture
//    func configGesture(view: UIView){
//        let tap = UITapGestureRecognizer(target: self, action: #selector(PerfilUsuarioViewController.handlePan(sender:)))
////        self.myServiceView.addGestureRecognizer(tap)
//    }
//
//    @objc func handlePan(sender:UITapGestureRecognizer){
//
//    }
    
    
//    @objc func tapGesture( sender:UITapGestureRecognizer){
//        print ("View foi selecionada.")
//    }
    
    
}
