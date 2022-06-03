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
    
    func list(){
        self.listServices.append(Services2(value: true, house: true, service: "Lavagem Simples", price: "R$ 80,00"))
        self.listServices.append(Services2(value: true, house: true, service: "Lavagem Completa", price: "R$ 80,00"))
        self.listServices.append(Services2(value: true, house: true, service: "Lavagem + Polimento", price: "R$ 80,00"))
        self.listServices.append(Services2(value: true, house: true, service: "Lavagem a seco", price: "R$ 80,00"))
        self.listServices.append(Services2(value: true, house: true, service: "Lavagem a vapor", price: "R$ 80,00"))
        self.listServices.append(Services2(value: true, house: true, service: "Variação: Ecolavagem", price: "R$ 80,00"))
        self.listServices.append(Services2(value: true, house: true, service: "Purificação de ar", price: "R$ 80,00"))
        self.listServices.append(Services2(value: true, house: true, service: "Higienização", price: "R$ 80,00"))
    }
    
    public func changeService(index: IndexPath, product: Services2){
        self.listServices[index.row] = product
    }
}
