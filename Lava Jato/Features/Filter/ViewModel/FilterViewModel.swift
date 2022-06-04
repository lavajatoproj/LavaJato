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
    
    private var listerPrice:[ProfilePrice] = []
    private var listGender:[ProfileGender] = []
    
    
    func configGender(){
        self.listGender.append(ProfileGender(nameM: "Profissionais homens", nameF: "Profissionais mulheres"))
    }
    
    
    func configPrice(){
        self.listerPrice.append(ProfilePrice(price: "Valor do serviço", priceMin: "R$20,00", priceMax: "R$800,00", place: "Onde você prefere fazer o serviço?"))
        self.listerPrice.append(ProfilePrice(price: "Valor do serviço", priceMin: "R$20,00", priceMax: "R$800,00", place: "Onde você prefere fazer o serviço?"))
    }
    
    func loadGender(indexPath:IndexPath) -> ProfileGender{
        return self.listGender[indexPath.row]
    }
    
    func loadPrice(indexPath:IndexPath) -> ProfilePrice{
        return self.listerPrice[indexPath.row]
    }
    
    func callFunc(){
        self.configPrice()
        self.configGender()
    }
    
    var coutArray:Int {
        return 2
    }
    var isFirstCell:Bool{
            return self.listGender.isEmpty
        }
    
    
    var indexPath = IndexPath()
    
    func loadHeighForRow(indexPath:IndexPath)-> CGFloat{
        if indexPath.row == 0 {
                    return 166.0
                }else{
                    return 466.0
       }
    }
    
    
}










