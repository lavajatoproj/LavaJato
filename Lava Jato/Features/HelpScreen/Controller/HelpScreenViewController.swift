//
//  HelpTableViewViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 21/02/22.
//

import UIKit
import MessageUI

class HelpScreenViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    private let viewModel:helpScreenViewModel = helpScreenViewModel()
    private var alert:AlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFuncs()
    }
    
    func getFuncs(){
        self.backgroundImageView.layer.cornerRadius = 15.0
        Style()
        self.alert = AlertController(controller: self)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["lavajato@dominio.com"])
            mail.setMessageBody("<p>Escreva sua mensagem para nós!</p>", isHTML: true)
            present(mail, animated: true)
        } else {
            self.alert?.showAlert(title: "Erro", message: "Você não possui o Mail instalado em seu dispositivo", titleButton: "Aceitar", completion: { value in
                print(#function)
            })
        }
    }
    func openWhatsApp(){
        let urlWhats = "https://wa.me/5511987625312?text=Bem vindo(a) ao Chat da Lava Jato"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                } else {
                    self.alert?.showAlert(title: "Erro", message: "Você não possui o WhatsApp instalado em seu dispositivo", titleButton: "Aceitar", completion: { value in
                        print(#function)
                    })
                }
            }
        }
    }
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
    @IBAction func buttonWhats(_ sender: Any) {
        self.openWhatsApp()
    }
    
    @IBAction func btEmail(_ sender: Any) {
        self.sendEmail()
    }
}
