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
    
    @IBAction func tappedMuteSwitch(_ sender: UISwitch) {
    }
    
    
    @IBAction func tappedMyServiceButton(_ sender: UIButton) {
        performSegue(withIdentifier: "meusServicos", sender: nil)
    }
    
    @IBAction func tappedHelpButton(_ sender: UIButton) {
//        performSegue(withIdentifier: "helpPageSegue", sender: nil)
    }
    
    @IBAction func tappedRecomendButton(_ sender: UIButton) {
    }
    
    @IBAction func tappedLogoutButton(_ sender: UIButton) {
        performSegue(withIdentifier: "exitAppSegue", sender: nil)
    }
    
    @IBAction func tappedEditProfile(_ sender: UIButton) {
//        performSegue(withIdentifier: "editProfileSegue", sender: nil)
    }
    @IBAction func tappedNotification(_ sender: UIButton) {
        performSegue(withIdentifier: "notificationSegue", sender: nil)
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
