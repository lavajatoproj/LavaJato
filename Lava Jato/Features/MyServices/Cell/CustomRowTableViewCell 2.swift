//
//  CustomRowTableViewCell.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 12/03/22.
//

import UIKit

class CustomRowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var back2View: UIView!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    
    static let identifier:String = "CustomRowTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
            self.back2View.layer.cornerRadius = 15
    }
    
    public func setupCell(product:String){
        self.productLabel.text = product
        self.switch.isHidden = true
    }
    
    
    
}
