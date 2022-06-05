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
//    var users: [Dictionary<String, Any>] = []
    var idUserLog: String?
    
    func getProfileData(){
        let user = self.firestore?.collection("users").document(self.idUserLog ?? "")
        user?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                let dataName = data?["name"]
                self.nameLabel.text = dataName as? String
                if let url = data?["profileImage"] as? String{
                    self.userImageView.sd_setImage(with: URL(string: url), completed: nil)
                }
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
        self.userImageView.contentMode = .scaleAspectFill
        self.userImageView.layer.cornerRadius = userImageView.frame.height / 2
        self.userImageView.clipsToBounds = true
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
        self.presentShareSheet()
    }
    
    @IBAction func tappedLogoutButton(_ sender: UIButton) {
        self.dismiss(animated: true)
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
    
    
}
