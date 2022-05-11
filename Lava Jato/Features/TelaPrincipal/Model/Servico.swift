//
//  Profile.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 12/03/22.
//

import Foundation
import UIKit

struct Servico{
    let title:String
    let image:UIImage
}

// Criando array para popular as cell
let servico: [Servico] = [
    Servico(title: "Lavagem Simples", image: #imageLiteral(resourceName: "LavagemSimples")),
    Servico(title: "Lavagem Completa", image: #imageLiteral(resourceName: "LavagemCompleta")),
    Servico(title: "Lavagem + Polimento", image: #imageLiteral(resourceName: "LavagemPolimento")),
    Servico(title: "Lavagem a Seco", image: #imageLiteral(resourceName: "LavagemSeco")),
    Servico(title: "Lavagem a Vapor", image: #imageLiteral(resourceName: "LavagemVapor")),
    Servico(title: "Eco Lavagem", image: #imageLiteral(resourceName: "VariacaoEcologica") ),
    Servico(title: "Purificação de Ar", image: #imageLiteral(resourceName: "PurificacaoAr")),
    Servico(title: "Higienização", image: #imageLiteral(resourceName: "Higienizacao")),
//    Servico(title: "Lavagem Simples", image:#imageLiteral(resourceName: "lavagemSimple.png") ),
//    Servico(title: "Lavagem Completa", image: #imageLiteral(resourceName: "lavagemCompleta.png")),
//    Servico(title: "Lavagem + Polimento", image:#imageLiteral(resourceName: "polimento.png") ),
//    Servico(title: "Lavagem a Seco", image: #imageLiteral(resourceName: "lavagemSeco.png")),
//    Servico(title: "Lavagem a Vapor", image:#imageLiteral(resourceName: "lavagemVapor.png") ),
//    Servico(title: "Eco Lavagem", image:#imageLiteral(resourceName: "ecoLavagem.png") ),
//    Servico(title: "Purificação de Ar", image: #imageLiteral(resourceName: "purificacaoAr.png")),
//    Servico(title: "Higienização", image: #imageLiteral(resourceName: "higienização.png")),
//    Servico(title: "Lavagem Simples", image:#imageLiteral(resourceName: "lavagemSimple.png") ),
//    Servico(title: "Lavagem Completa", image: #imageLiteral(resourceName: "lavagemCompleta.png")),
//    Servico(title: "Lavagem + Polimento", image:#imageLiteral(resourceName: "polimento.png") ),
//    Servico(title: "Lavagem a Seco", image: #imageLiteral(resourceName: "lavagemSeco.png")),
//    Servico(title: "Lavagem a Vapor", image:#imageLiteral(resourceName: "lavagemVapor.png") ),
//    Servico(title: "Eco Lavagem", image:#imageLiteral(resourceName: "ecoLavagem.png") ),
//    Servico(title: "Purificação de Ar", image: #imageLiteral(resourceName: "purificacaoAr.png")),
//    Servico(title: "Higienização", image: #imageLiteral(resourceName: "higienização.png"))
]

