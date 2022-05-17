//
//  RequestViewModel.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 12/05/22.
//

import Foundation
import UIKit

class RequestViewModel{
    
    var listServices:[Services] =  []
    
    func listService(){
    self.listServices.append(Services(opened: false, title: "Selecione o serviço", service: ["","Lavagem Simples", "Lavagem Completa", "Lavagem + Polimento","Lavagem a seco","Lavagem a vapor","Variação: Ecolavagem","Purificação de ar","Higienização"], price: ["R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00", "R$ 80,00","R$ 80,00","R$ 80,00"]));
    self.listServices.append(Services(opened: false, title: "Modo de retirada", service: ["","Levarei ao local", "Buscar aqui"], price: [""]))
    }
    
}
