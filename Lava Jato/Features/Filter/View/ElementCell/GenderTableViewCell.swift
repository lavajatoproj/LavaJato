//
//  ElementTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 16/03/22.
//

import UIKit

protocol GenderTableViewCellDelegate:AnyObject{
    func tappedSwitch(stateM:Bool,stateF:Bool)
}

class GenderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var manLabel: UILabel!
    @IBOutlet weak var womanLabel: UILabel!
    @IBOutlet weak var manSwitch: UISwitch!
    @IBOutlet weak var womanSwitch: UISwitch!

    static let identifier:String = "GenderTableViewCell"
    static func nib()->UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    private weak var delegate:GenderTableViewCellDelegate?
    
    public func delegate(delegate:GenderTableViewCellDelegate?){
        self.delegate = delegate
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.manLabel.text = "Profissionais Homens"
        self.womanLabel.text = "Profissionais Mulheres"
    }
    
    public func setupCell(profile:ProfileGender){
        self.manSwitch.isOn = profile.stateM
        self.womanSwitch.isOn = profile.stateF
    }
    
    private func tappedSwitch(){
        self.delegate?.tappedSwitch(stateM: self.manSwitch.isOn, stateF: self.womanSwitch.isOn)
    }

    @IBAction func ativoMSwitch(_ sender: UISwitch) {
        self.tappedSwitch()
    }
    @IBAction func ativoFSwitch(_ sender: UISwitch) {
        self.tappedSwitch()
    }
    
    
}
