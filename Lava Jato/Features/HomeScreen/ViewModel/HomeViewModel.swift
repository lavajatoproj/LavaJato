//
//  MainViewModel.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 11/05/22.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol HomeViewModelDelegate:AnyObject{
    
}


class HomeViewModel{

    func minimumLine(collectionView:UICollectionViewLayout) -> CGFloat{
        return 15
    }
}
