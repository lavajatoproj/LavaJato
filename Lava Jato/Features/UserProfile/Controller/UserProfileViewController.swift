//
//  PerfilUsuarioViewController.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 07/03/22.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    private var viewModel:UserProfileViewModel = UserProfileViewModel()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var silenceButton: UIButton!
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
        self.nameLabel.text = self.getUserDefaults(key:"userName")as? String
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
    
    @IBAction func tappedActiveSilence(_ sender: UIButton) {
        self.silenceButton.isSelected = !self.silenceButton.isSelected
        if self.silenceButton.isSelected {
           self.silenceButton.setImage(UIImage(named: "mute32"), for: .normal)
        } else {
           self.silenceButton.setImage(UIImage(named: "volume32"), for: .normal)
        }
    }
    
    @IBAction func tappedNotification(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "NotificationViewController", bundle: nil)
        let vC = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
        navigationController?.pushViewController(vC, animated: true)
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
        self.silenceButton.setImage(UIImage(named: "volume32"), for: .normal)
        
    }
    
    // salvar nome do profile
    public func getUserDefaults(key: String)-> Any?{
        return UserDefaults.standard.object(forKey: key)
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
