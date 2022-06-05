//
//  ElementTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 16/03/22.
//

import UIKit

class GenderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var manLabel: UILabel!
    @IBOutlet weak var womanLabel: UILabel!
    @IBOutlet weak var manSwitch: UISwitch!
    @IBOutlet weak var womanSwitch: UISwitch!

    
    
    static let identifier:String = "GenderTableViewCell"
    static func nib()->UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupCell(profile:ProfileGender){
        self.manLabel.text = profile.nameM
        self.womanLabel.text = profile.nameF
    }

    @IBAction func ativoMSwitch(_ sender: UISwitch) {
        
    }
    @IBAction func ativoFSwitch(_ sender: UISwitch) {
        
    }
    
    
    
}
