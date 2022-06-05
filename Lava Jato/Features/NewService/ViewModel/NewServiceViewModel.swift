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
}



class NewServiceViewModel{
    private weak var delegate: NewServiceViewModelDelegate?
    public func delegate(delegate: NewServiceViewModelDelegate?){
        self.delegate = delegate
    }
    
    private let personService:PersonService = PersonService()
    private var infos: Users?
    
    let fireStore = Firestore.firestore()
    var newService:NewServiceViewController = NewServiceViewController()
    var professionals:[Professionals] = []
    
    func getFireBaseData(){
        fireStore.collection("users").getDocuments { snapshot, error in
            if error == nil{
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.professionals = snapshot.documents.map({ document in
                            return Professionals(userImage: document["profileImage"] as? UIImage ?? UIImage(),
                                                 userName: document["name"] as? String ?? "")
                        })
                    }
                    self.newService.tableView.reloadData()
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
    
    
}
