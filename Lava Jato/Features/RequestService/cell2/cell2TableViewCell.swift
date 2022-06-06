//
//  cell2TableViewCell.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 06/06/22.
//

import UIKit

class cell2TableViewCell: UITableViewCell {

    @IBOutlet weak var observTextField: UITextField!
    
    static let identifier:String = "cell2TableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.observTextField.isHidden = false
    }
}
