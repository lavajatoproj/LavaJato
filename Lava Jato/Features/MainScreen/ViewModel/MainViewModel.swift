//
//  MainViewModel.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 11/05/22.
//

import Foundation
import UIKit


class MainViewModel{
    
    
    private var arrayNames2:[Professionals] = [
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Thiago", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: false, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Bruno", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: false, washPolishing: false, dryWash: false, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Olivia", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Fred", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: true, ecoWash: false, airPurification: false, sanitation: true)])

    ]
    
    
}
