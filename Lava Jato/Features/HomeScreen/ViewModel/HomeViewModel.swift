//
//  MainViewModel.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 11/05/22.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol HomeViewModelDelegate:AnyObject{}


class HomeViewModel{
    
    func loadHeighForRow(indexPath:IndexPath)-> CGFloat{
        if indexPath.row == 0 {
            return 166.0
        }else{
            return 510.0
        }
    }

}
