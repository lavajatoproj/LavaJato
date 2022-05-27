//
//  Model.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 12/03/22.
//

import Foundation
import UIKit

struct Services{
    var opened: Bool
    var title:String
    var service: [String]
    var price: [String]
}


// MARK: - Service

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

// MARK: - ProfileBanner

struct ProfileBanner {
    let imgA:UIImage
}
      
let dataPlace: [ProfileBanner] = [
    ProfileBanner(imgA: #imageLiteral(resourceName: "emCasa")),
    ProfileBanner(imgA: #imageLiteral(resourceName: "busque")),
    ProfileBanner(imgA: #imageLiteral(resourceName: "levar"))
]

// MARK: - ProfilePrice

struct ProfilePrice{
    let price:String
    var priceMin:String
    var priceMax:String
    let place:String
}

// MARK: - ProfileGenre

struct ProfileGender{
    let nameM:String
    let nameF:String
}

