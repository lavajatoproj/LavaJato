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
