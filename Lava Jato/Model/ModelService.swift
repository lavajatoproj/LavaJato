//
//  ModelService.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 11/05/22.
//

import Foundation
import UIKit

struct Professionals{
    var userImage:UIImage
    var userName:String
    var userRate:Double
    var userServices:[WashServices]
}


struct WashServices{
    var simpleWash:Bool
    var completWash:Bool
    var washPolishing:Bool
    var dryWash:Bool
    var steamWash:Bool
    var ecoWash:Bool
    var airPurification:Bool
    var sanitation:Bool
}
