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
        self.listServices.append(Services (value: true, house: true, service: ["Lavagem Simples", "Lavagem Completa", "Lavagem + Polimento","Lavagem a seco","Lavagem a vapor","Variação: Ecolavagem","Purificação de ar","Higienização"], price: ["R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00","R$ 80,00","R$ 80,00"]))
    }
}
