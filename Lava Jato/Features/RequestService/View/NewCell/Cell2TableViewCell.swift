//
//  Cell2TableViewCell.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 08/06/22.
//

import UIKit

class Cell2TableViewCell: UITableViewCell {
    
    static let identifier:String = "Cell2TableViewCell"
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
