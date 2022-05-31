//
//  PerfilUsuarioViewController.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 07/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorageUI

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tappedMuteSwitch: UISwitch!
    @IBOutlet weak var muteImageView: UIImageView!
    @IBOutlet weak var tappedMyServiceButton: UIButton!
    @IBOutlet weak var tappedHelpButton: UIButton!
    @IBOutlet weak var tappedRecomendButton: UIButton!
    @IBOutlet weak var tappedLogoutButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    var firestore: Firestore?
    var auth: Auth?
//    var users: [Dictionary<String, Any>] = []
    var idUserLog: String?
    
    func getProfileData(){
        let user = self.firestore?.collection("users").document(self.idUserLog ?? "")
        user?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                let dataName = data?["name"]
                self.nameLabel.text = dataName as? String
//                if let url = data1?["url"] as? String{
//                    self.userImageView.sd_setImage(with: URL(string: url), completed: nil)
//                }
                }
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Style()
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        if let idUser = auth?.currentUser?.uid{
            self.idUserLog = idUser
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.getProfileData()
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
        self.dismiss(animated: true)
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
