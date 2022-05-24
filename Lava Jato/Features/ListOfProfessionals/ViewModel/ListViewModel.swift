//
//  ListViewModel.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 11/05/22.
//

//import Foundation
//import UIKit
//
////protocol ListViewModelDelegate:AnyObject{
////    func success()
////    func error()
////}
//
//class ListViewModel{
//    
////    private weak var delegate: ListViewModelDelegate?
////    public func delegate(delegate: ListViewModelDelegate?){
////        self.delegate = delegate
//    }
//    
//    private let service: PersonService = PersonService()
//    private var infos: Users?
    
//    public var countElements:Int{
//        return self.infos?.registerUsers?.count ?? 0
////        print(self.infos?.registerUsers?.count)
//    }
    
//    public func loadUsers(indexPath: IndexPath) -> RegisterUser{
//        return infos?.registerUsers?[indexPath.row] ?? RegisterUser()
//    }
    
//    public func fetchHistory(){
//        self.service.getPersonAlamofire { success, error in
//            if let _success = success{
//                self.infos = _success
//                self.delegate?.success()
//            }else{
//                self.delegate?.error()
//            }
//        }
//    }
    
//}
