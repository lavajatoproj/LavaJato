//
//  RequestViewModel.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 12/05/22.
//

import Foundation
import UIKit

class RequestViewModel{

    var listServices:[Server] =  []

    func listService(){
        self.listServices.append(Server(opened: false, title: "Serviços", service: ["","Lavagem Simples", "Lavagem Completa", "Lavagem + Polimento","Lavagem a seco","Lavagem a vapor","Variação: Ecolavagem","Purificação de ar","Higienização"]))
        self.listServices.append(Server(opened: false, title: "Local do serviço", service: [ "","Levarei ao local", "Buscar aqui", "Serviço em domicílio"]))
        self.listServices.append(Server(opened: false, title: "", service: [""]))
    }
}
