//
//  FilterViewModel.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 09/05/22.
//

import UIKit

protocol FilterViewModelDelegate:AnyObject{
    func success()
    func error()
}

class FilterViewModel{
    
    private weak var delegate:FilterViewModelDelegate?
    public func delegate(delegate:FilterViewModelDelegate?){
        self.delegate = delegate
    }
    
    init(professionalMen:Bool,professionalFemale:Bool,currentPriceMin:Double,currentPriceMax:Double,currentHomeService:Bool,currentTakeService:Bool,currentGoToLocal:Bool){
        self.professionalMen = professionalMen
        self.professionalFemale = professionalFemale
        self.currentPriceMin = currentPriceMin
        self.currentPriceMax = currentPriceMax
        self.homeService = currentHomeService
        self.takeService = currentTakeService
        self.goToService = currentGoToLocal
    }
    
    private var professionalMen:Bool
    private var professionalFemale:Bool
    private var currentPriceMin:Double
    private var currentPriceMax:Double
    private var homeService:Bool
    private var takeService:Bool
    private var goToService:Bool
    
    
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
        return self.goToService
    }
    
    public var getGender: ProfileGender{
        return ProfileGender(stateM: self.professionalMen,stateF: self.professionalFemale)
    }
    
    public var getPrice: ProfilePrice{
        return ProfilePrice(currentPriceMin: self.currentPriceMin, currentPriceMax: self.currentPriceMax)
    }
    
    lazy var getProfileBanner: [ProfileBanner] = [
        ProfileBanner(imgA: #imageLiteral(resourceName: "frame16.png"), isSelect: self.getLocalForService.currentTakeService),
        ProfileBanner(imgA: #imageLiteral(resourceName: "frame17.png"), isSelect: self.getLocalForService.currentHomeService),
        ProfileBanner(imgA: #imageLiteral(resourceName: "frame18.png"), isSelect: self.getLocalForService.currentGoToLocal)
    ]
    
    public var getLocalForService:ProfileLocalService{
        return ProfileLocalService(currentHomeService: self.homeService, currentTakeService: self.takeService , currentGoToLocal: self.goToService )
    }
    
    var countArray:Int {
        return 2
    }
    
    func loadHeighForRow(indexPath:IndexPath)-> CGFloat{
        if indexPath.row == 0 {
            return 166.0
        }else{
            return 510.0
        }
    }
    
    public func setStateSexo(stateM: Bool, stateF: Bool){
        self.professionalMen = stateM
        self.professionalFemale = stateF
    }
}










