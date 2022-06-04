//
//  ServiceViewModel.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 12/05/22.
//

import Foundation
import UIKit

class ServiceViewModel{
    
    var listServices:[Services2] =  []
    var xuxu:String?
    
    func list(){
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem Simples", price: "R$ 80,00"))
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem Completa", price: "R$ 80,00"))
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem + Polimento", price: "R$ 80,00"))
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem a seco", price: "R$ 80,00"))
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem a vapor", price: "R$ 80,00"))
        self.listServices.append(Services2(value: false, house: false, service: "Variação: Ecolavagem", price: "R$ 80,00"))
        self.listServices.append(Services2(value: false, house: false, service: "Purificação de ar", price: "R$ 80,00"))
        self.listServices.append(Services2(value: false, house: false, service: "Higienização", price: "R$ 80,00"))
    }
    
    public func changeService(index: IndexPath, product: Services2){
        self.listServices[index.row] = product
    }
    
    
}
