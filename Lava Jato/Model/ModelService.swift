//
//  ModelService.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 11/05/22.
//

import Foundation
import UIKit


//TO DO: ADD GENDER E O TYPE
struct Professionals{
    var userImage:UIImage
    var userName:String
    var id:String
    var price:Double
    var house:Bool
    var service:String
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


struct ServiceList{
    var typeService:String
}
