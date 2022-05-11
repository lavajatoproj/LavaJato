//
//  ViewModel.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 04/05/22.
//

import UIKit

class ViewModelNotificationScreen {
    
    private var data:[Profile] = [
        Profile(name: "Nome: Junyor", photo: UIImage(imageLiteralResourceName: "profile1"), adress: "Endereço: Rua numero, 2315 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Completa ", payment: "Tipo do Pagamento: Dinheiro"),
        Profile(name: "Nome: Brendon", photo: UIImage(imageLiteralResourceName: "profile2"), adress: "Endereço: Rua numero, 121 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Simples ", payment: "Tipo do Pagamento: Cartão de Débito"),
        Profile(name: "Nome: Thiago", photo: UIImage(imageLiteralResourceName: "profile3"), adress: "Endereço: Rua numero, 1123 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Polimento e Cristalização ", payment: "Tipo do Pagamento: PIX"),
        Profile(name: "Nome: Claudio", photo: UIImage(imageLiteralResourceName: "profile1"), adress: "Endereço: Rua numero, 2221 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Simples ", payment: "Tipo do Pagamento: Cartão de Crédito")
        
    ]
    
    func loadCellUser(indexPath:IndexPath)->Profile{
        return self.data[indexPath.row]
    }
    
    var countElementsArray:Int{
        return self.data.count
    }
    
    func removeIndex(indexPath:IndexPath)->Profile{
        self.data.remove(at: indexPath.row)
    }
}
