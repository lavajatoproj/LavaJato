//
//  FilterViewModel.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 09/05/22.
//

import UIKit


class FilterViewModel{
    
    private var listerPrice:[ProfilePrice] = []
    private var listGender:[ProfileGender] = []
    
    func configPrice(){
        self.listerPrice.append(ProfilePrice(price: "Valor do serviço", priceMin: "R$20,00", priceMax: "R$800,00", place: "Onde você prefere fazer o serviço?"));
        self.listerPrice.append(ProfilePrice(price: "Valor do serviço", priceMin: "R$20,00", priceMax: "R$800,00", place: "Onde você prefere fazer o serviço?"))
    }
    
    func configGender(){
        self.listGender.append(ProfileGender(nameM: "Profissionais homem", nameF: "Profissionais mulher"));
        self.listGender.append(ProfileGender(nameM: "Profissionais homem", nameF: "Profissionais mulher"))
    }
                               
    func loadPrice(indexPath:IndexPath) -> ProfilePrice{
            return self.listerPrice[indexPath.row]
        }
                               
    func loadGender(indexPath:IndexPath) -> ProfileGender{
            return self.listGender[indexPath.row]
      }
    
    func callFunc(){
        self.configPrice()
        self.configGender()
    }
    
    var coutArray:Int {
        return self.listGender.count
    }
    
    var isFirstCell:Bool{
        return self.listGender.isEmpty
    }
    
 }








