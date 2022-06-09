//
//  ListViewModel.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 11/05/22.
//

import Foundation
import UIKit

class ListViewModel{

    private var professionalMen:Bool = true
    private var professionalFemale:Bool = true
    private var currentPriceMin:Double = 0.0
    private var currentPriceMax:Double = 0.0
    private var homeService:Bool = false
    private var takeService:Bool = false
    private var goToLocal:Bool = false
    
    
    public var getProfessionalMen:Bool{
        return self.professionalMen
    }
    
    public var getProfessionalFemale:Bool{
        return self.professionalFemale
    }
    
    public var getCurrentPriceMin:Double{
        return self.currentPriceMin
    }
    
    public var getCurrentPriceMax:Double{
        return self.currentPriceMax
    }
    
    public var getHomeService:Bool{
        return self.homeService
    }
    
    public var getTakeService:Bool{
        return self.takeService
    }
    
    public var getGoToService:Bool{
        return self.goToLocal
    }
    
    public func setFilter(professionalMen: Bool, professionalFemale: Bool, currentPriceMin: Double, currentPriceMax: Double, homeService:Bool, takeService:Bool, goToService:Bool){
        self.professionalMen = professionalMen
        self.professionalFemale = professionalFemale
        self.currentPriceMin = currentPriceMin
        self.currentPriceMax = currentPriceMax
        self.homeService = homeService
        self.takeService = takeService
        self.goToLocal = goToService
    }
    
    public func clearFilter(){
        self.professionalMen = true
        self.professionalFemale = true
        self.currentPriceMin = 0.0
        self.currentPriceMax = 0.0
        self.homeService = false
        self.takeService = false
        self.goToLocal = false
    }
}
