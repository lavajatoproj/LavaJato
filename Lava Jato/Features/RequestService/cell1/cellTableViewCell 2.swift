//
//  cellTableViewCell.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 14/03/22.
//

import UIKit

class cellTableViewCell: UITableViewCell {

    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var back2View: UIView!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    
    
    static let identifier:String = "cellTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
            self.back2View.layer.cornerRadius = 15
    }
    
    public func setupCell(product:String){
        self.productLabel.text = product
        
    }
    
}
