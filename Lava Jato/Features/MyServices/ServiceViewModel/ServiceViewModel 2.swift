//
//  ServiceViewModel.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 12/05/22.
//

import Foundation
import UIKit

class ServiceViewModel{
    
    var listServices:[Services] =  []
    
    func list(){
    self.listServices.append(Services(opened: false, title: "Meus serviços", service: ["","Lavagem Simples", "Lavagem Completa", "Lavagem + Polimento","Lavagem a seco","Lavagem a vapor","Variação: Ecolavagem","Purificação de ar","Higienização"], price: ["R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00","R$ 80,00","R$ 80,00"]))
    self.listServices.append(Services(opened: false, title: "Formas de serviço", service: ["","Busco em casa", "Atendo no local"], price: [""]))
    self.listServices.append(Services(opened: false, title: "Preço", service: ["","Lavagem Simples", "Lavagem Completa", "Lavagem + Polimento","Lavagem a seco","Lavagem a vapor","Variação: Ecolavagem","Purificação de ar","Higienização"], price: [""]))
    }
}
