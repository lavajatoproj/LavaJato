//
//  AlertController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 04/05/22.
//

import Foundation
import UIKit

enum ActionType{
    case aceitar
    case cancel
}

class AlertController {

    var controller:UIViewController
    
    init(controller:UIViewController){
        self.controller = controller
    }
    func showAlert(title:String,message:String,titleButton:String,completion:@escaping(_ value:ActionType)-> Void){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let aceitar = UIAlertAction(title: titleButton, style: .default) { alert in
            print("aceitar pressionado")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .default) { _ in
            completion(.cancel)
        }
        
        alert.addAction(aceitar)
        self.controller.present(alert, animated: true)
    }
    
}
