//
//  NewServiceViewModel.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 15/05/22.
//

import Foundation
import UIKit

protocol NewServiceViewModelDelegate:AnyObject{
    func success()
    func error()
}



class NewServiceViewModel{
    
    private weak var delegate: NewServiceViewModelDelegate?
    public func delegate(delegate: NewServiceViewModelDelegate?){
        self.delegate = delegate
    }
    
     var arrayNames2:[Professionals] = [
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Thiago", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: false, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Bruno", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: false, washPolishing: false, dryWash: false, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Olivia", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Fred", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: true, ecoWash: false, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Joao", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: true, washPolishing: true, dryWash: true, steamWash: true, ecoWash: true, airPurification: true, sanitation: true)])

    ]
    
    
    private let newService:PersonService = PersonService()
    private var infos: Users?
    
    public var countElements:Int{
        return self.infos?.registerUsers?.count ?? 0
    }
    
    public func loadUsers(indexPath: IndexPath) -> RegisterUser{
        return infos?.registerUsers?[indexPath.row] ?? RegisterUser()
    }
    
    public func fetchHistory(){
        self.newService.getPersonAlamofire { success, error in
            if let _success = success{
                self.infos = _success
                self.delegate?.success()
            }else{
                self.delegate?.error()
            }
        }
    }
    
    
}
