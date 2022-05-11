//
//  HelpTableViewViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 21/02/22.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundImageView.layer.cornerRadius = 15.0
        Style()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonWhats(_ sender: Any) {
        
        var str = "Bem vindo ao Chat da Lava Jato"
        str = str.addingPercentEncoding(withAllowedCharacters: (NSCharacterSet.urlQueryAllowed))!
        let whatsappURL = NSURL(string: "https://api.whatsapp.com/send?phone=989381485&text=\(str)")

        if UIApplication.shared.canOpenURL(whatsappURL! as URL) {
            UIApplication.shared.openURL(whatsappURL! as URL)
        } else {
//            Falta implementar a funcao para o showAlert
//            showAlert(message: "O Whatsapp não está instalado neste dispositivo. Instale o Whatsapp e tente novamente.")
        }
    }
    
    
    @IBAction func btEmail(_ sender: Any) {
        
        let email = "junynho2011@gmail.com"
        if let url = NSURL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
              UIApplication.shared.open(url as URL)
          } else {
              UIApplication.shared.openURL(url as URL)
          }
        }
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
}
