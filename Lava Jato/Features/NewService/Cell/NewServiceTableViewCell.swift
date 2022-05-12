//
//  NewServiceTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 11/05/22.
//

import UIKit

class NewServiceTableViewCell: UITableViewCell {

    
    
    static let identifier:String = "NewServiceTableViewCell"
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }


    
    
    
}
