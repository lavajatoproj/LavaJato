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
class ListViewModel{
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
    
    // MARK: - Adicionado  para pegar valores do filter
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
    
    public func setFilter(professionalMen: Bool, professionalFemale: Bool, currentPriceMin: Double, currentPriceMax: Double){
        self.professionalMen = professionalMen
        self.professionalFemale = professionalFemale
        self.currentPriceMin = currentPriceMin
        self.currentPriceMax = currentPriceMax
        
        //TO DO: Fazer o filter de acordo com oque ele escolheu:
        //        self.listUserFilter = self.serviceProviders.filter({$0.price < currentPriceMax && $0.price > currentPriceMin && $0.userName == "Caio"})
    }
}
