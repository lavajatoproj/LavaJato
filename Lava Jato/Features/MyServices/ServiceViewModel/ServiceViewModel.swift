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
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem Simples", price: 80.00, goInHouse: false, haveLocation: false))
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem Completa", price: 80.00, goInHouse: false, haveLocation: false))
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem + Polimento", price: 80.00, goInHouse: false, haveLocation: false))
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem a seco", price: 80.00, goInHouse: false, haveLocation: false))
        self.listServices.append(Services2(value: false, house: false, service: "Lavagem a vapor", price: 80.00, goInHouse: false, haveLocation: false))
        self.listServices.append(Services2(value: false, house: false, service: "Variação: Ecolavagem", price: 80.00, goInHouse: false, haveLocation: false))
        self.listServices.append(Services2(value: false, house: false, service: "Purificação de ar", price: 80.00, goInHouse: false, haveLocation: false))
        self.listServices.append(Services2(value: false, house: false, service: "Higienização" , price: 80.00, goInHouse: false, haveLocation: false))
    }
    
    public func changeService(index: IndexPath, product: Services2){
        self.listServices[index.row] = product
    }
    
    
}
