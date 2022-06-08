//
//  Model.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 12/03/22.
//

import Foundation
import UIKit

struct Services{
    var value: Bool
    var house: Bool
    var service: [String]
    var price: [String]
}

struct Services2{
    var value: Bool
    var house: Bool
    var service: String
    var price: String
}

struct Server{
    var opened: Bool
    var title: String
    var service: [String]
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
    var imgA:UIImage
    var isSelect:Bool
}
      
var dataPlace: [ProfileBanner] = [
    ProfileBanner(imgA: #imageLiteral(resourceName: "frame16.png"), isSelect: false),
    ProfileBanner(imgA: #imageLiteral(resourceName: "frame17.png"), isSelect: false),
    ProfileBanner(imgA: #imageLiteral(resourceName: "frame18.png"), isSelect: false)
]

// MARK: - ProfilePrice

struct ProfilePrice{
    var currentPriceMin:Double
    var currentPriceMax:Double
}

// MARK: - ProfileGenre

struct ProfileGender{
    let stateM:Bool
    let stateF:Bool
}

