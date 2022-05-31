//
//  CustomRowTableViewCell.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 12/03/22.
//

import UIKit

class CustomRowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var serviceSwitch: UISwitch!
    @IBOutlet weak var houseSwitch: UISwitch!
    @IBOutlet weak var priceTextField: UITextField!
    
    static let identifier:String = "CustomRowTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
            self.contentView.layer.cornerRadius = 15
    }
    
    public func setupCell(product:String){
        self.productLabel.text = product
        self.serviceSwitch.isHidden = false
        self.houseSwitch.isHidden = false
    }
    
    
    
}
