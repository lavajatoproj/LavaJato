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
    
    
    @IBOutlet weak var silenceButton: UIButton!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var muteImageView: UIImageView!
    @IBOutlet weak var tappedMyServiceButton: UIButton!
    @IBOutlet weak var tappedHelpButton: UIButton!
    @IBOutlet weak var tappedRecomendButton: UIButton!
    @IBOutlet weak var tappedLogoutButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    var firestore: Firestore?
    var auth: Auth?
    var idUserLog: String?
    var alert:AlertController?
    
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
        self.alert = AlertController(controller: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.getProfileData()
    }
    
    @IBAction func tappedMyServiceButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ProfileEditViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "ProfileEditViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func tappedHelpButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HelpScreenViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "HelpScreenViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    
    
    @IBAction func tappedRecomendButton(_ sender: UIButton) {
        print("Test")
        self.presentShareSheet()
    }
    
    
    @IBAction func tappedLogoutButton(_ sender: UIButton) {
        do {
            try auth?.signOut()
            let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
            let vC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            navigationController?.pushViewController(vC, animated: true)
        } catch let signOutError {
            self.alert(title:"Ops", message: "Error ao desconectar")
        }
    }
    
    @IBAction func tappedEditProfile(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ProfileEditViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "ProfileEditViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    @IBAction func tappedActiveSilence(_ sender: UIButton) {
        self.silenceButton.isSelected = !self.silenceButton.isSelected
        if self.silenceButton.isSelected {
            self.silenceButton.setImage(UIImage(named: "mute32"), for: .normal)
        } else {
            self.silenceButton.setImage(UIImage(named: "volume32"), for: .normal)
        }
        
    }
    @IBAction func tappedNotification(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ServicesViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "ServicesViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
        self.silenceButton.setImage(UIImage(named: "volume32"), for: .normal)
    }
    
    
    func presentShareSheet(){
        let text = "Um novo conceito em cuidado com seu veículo."
        let image = UIImage(named: "AppIcon") ?? UIImage()
        let myWebsite = NSURL(string:"https://github.com/lavajatoproj/LavaJato")
        let shareAll = [text, image, myWebsite ?? ""] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    func alert(title:String, message:String){
         let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let ok:UIAlertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
         alertController.addAction(ok)
         self.present(alertController, animated: true, completion: nil)
     }
    
}
