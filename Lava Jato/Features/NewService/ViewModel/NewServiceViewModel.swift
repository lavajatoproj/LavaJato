//
//  NewServiceViewModel.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 15/05/22.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol NewServiceViewModelDelegate:AnyObject{
    func success()
    func error()
    func reloadTableView()
}


class NewServiceViewModel{
    
    private weak var delegate: NewServiceViewModelDelegate?
    
    public func delegate(delegate: NewServiceViewModelDelegate?){
        self.delegate = delegate
    }
    
    private let personService:PersonService = PersonService()
    private var infos: Users?
    private let firestore = Firestore.firestore()
    
    private var serviceProviders:[Professionals] = []
    public var listUserFilter:[Professionals] = []
    
    var users: [Dictionary<String, Any>] = []
    
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
    
    public func getFireBaseData(washType:String){
        
        firestore.collection(washType).getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.serviceProviders = snapshot.documents.map({ document in
                            return Professionals(
                                userImage: document["profileImage"] as? String ?? "",
                                userName: document["nameData"] as? String ?? "",
                                id: document["id"] as? String ?? "",
                                price: document["price"] as? Double ?? 0.0,
                                homeService: document["house"] as? Bool ?? false,
                                serviceType: document["service"] as? String ?? "",
                                goToService: document["goInHouse"] as? Bool ?? false,
                                takeService: document["service"] as? Bool ?? false,
                                professionalGender: document["genderData"] as? String ?? "",
                                localCity: document["cityData"] as? String ?? ""
                            )
                        })
                        print( self.serviceProviders)
                        self.listUserFilter = self.serviceProviders
                        self.delegate?.reloadTableView()
                    }
                }
            }
        }
    }
    
    public var countElements:Int{
        return self.infos?.registerUsers?.count ?? 0
    }
    
    public func loadUsers(indexPath: IndexPath) -> RegisterUser{
        return infos?.registerUsers?[indexPath.row] ?? RegisterUser()
    }
    
    public func fetchHistory(){
        self.personService.getPersonAlamofire { success, error in
            if let _success = success{
                self.infos = _success
                self.delegate?.success()
            }else{
                self.delegate?.error()
            }
        }
    }
    
    public func searchUsers(text: String ){
        if text.isEmpty{
            self.listUserFilter = self.serviceProviders
        }else{
            self.listUserFilter = self.serviceProviders.filter({$0.userName.uppercased().contains(text.uppercased())})
        }
    }
    
    public var countElemented:Int{
       return self.listUserFilter.count
    }
    
    public func loudCurrentProfessional(indexPath:IndexPath)-> Professionals{
        return self.listUserFilter[indexPath.row]
    }
    
    func loadHeighForRow(indexPath:IndexPath)-> CGFloat{
       return 138
    }
    
    public func setFilter(professionalMen: Bool, professionalFemale: Bool, currentPriceMin: Double, currentPriceMax: Double, homeService:Bool, takeService:Bool, goToService:Bool){
        self.professionalMen = professionalMen
        self.professionalFemale = professionalFemale
        self.currentPriceMin = currentPriceMin
        self.currentPriceMax = currentPriceMax
        self.homeService = homeService
        self.takeService = takeService
        self.goToLocal = goToService
        
        if professionalMen  == true && professionalFemale == true{
            self.listUserFilter = self.serviceProviders.filter({ $0.professionalGender == "Masculino" || $0.professionalGender == "Feminino"})
        }else if professionalMen{
            self.listUserFilter = self.serviceProviders.filter({ $0.professionalGender == "Masculino"})
        }else{
            self.listUserFilter = self.serviceProviders.filter({ $0.professionalGender == "Feminino"})
        }
        
        
        if !(currentPriceMin == 0 && currentPriceMax == 0) {
                self.listUserFilter = self.listUserFilter.filter({$0.price < currentPriceMax && $0.price > currentPriceMin})
        }
        
        self.listUserFilter = self.listUserFilter.filter({$0.homeService == homeService && $0.takeService == takeService && $0.goToService == goToService})
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


