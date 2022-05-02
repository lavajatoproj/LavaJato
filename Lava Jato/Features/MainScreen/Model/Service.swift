//
//  Profile.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 12/03/22.
//

import Foundation
import UIKit

struct Service{
    let title:String
    let image:UIImage
}


let service: [Service] = [
    Service(title: "Lavagem Simples", image: #imageLiteral(resourceName: "LavagemSimples")),
    Service(title: "Lavagem Completa", image: #imageLiteral(resourceName: "LavagemCompleta")),
    Service(title: "Lavagem + Polimento", image: #imageLiteral(resourceName: "LavagemPolimento")),
    Service(title: "Lavagem a Seco", image: #imageLiteral(resourceName: "LavagemSeco")),
    Service(title: "Lavagem a Vapor", image: #imageLiteral(resourceName: "LavagemVapor")),
    Service(title: "Eco Lavagem", image: #imageLiteral(resourceName: "VariacaoEcologica") ),
    Service(title: "Purificação de Ar", image: #imageLiteral(resourceName: "PurificacaoAr")),
    Service(title: "Higienização", image: #imageLiteral(resourceName: "Higienizacao"))
]



