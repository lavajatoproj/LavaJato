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
    
    private var professionalMen:Bool = true
    private var professionalFemale:Bool = true
    private var currentPriceMin:Double = 0.0
    private var currentPriceMax:Double = 0.0

    
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
    
    public func getFireBaseData(washType:String){
        self.firestore.collection(washType).getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.serviceProviders = snapshot.documents.map({ document in
//                            let url = document["profileImage"] as? String
                            return Professionals(
                                userImage: document["profileImage"] as? String ?? "",
                                userName: document["userName"] as? String ?? "",
                                id: document["userID"] as? String ?? "",
                                price: document["price"] as? Double ?? 0.0,
                                homeService: document["house"] as? Bool ?? false,
                                serviceType: document["service"] as? String ?? "")
                        })
                        print( self.serviceProviders)
                        self.listUserFilter = self.serviceProviders
                      //TO DO: Delegate
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
    
    public func setFilter(professionalMen: Bool, professionalFemale: Bool, currentPriceMin: Double, currentPriceMax: Double){
        self.professionalMen = professionalMen
        self.professionalFemale = professionalFemale
        self.currentPriceMin = currentPriceMin
        self.currentPriceMax = currentPriceMax
        
        //TO DO: Fazer o filter de acordo com oque ele escolheu:
        self.listUserFilter = self.serviceProviders.filter({$0.price < currentPriceMax && $0.price > currentPriceMin && $0.userName == "Thiago"})
//        self.listUserFilter = self.serviceProviders.filter({$0.price < currentPriceMax && $0.price > currentPriceMin})
    }
    
    public func clearFilter(){
        self.professionalMen = true
        self.professionalFemale = true
        self.currentPriceMin = 0.0
        self.currentPriceMax = 0.0
    }
    
}


