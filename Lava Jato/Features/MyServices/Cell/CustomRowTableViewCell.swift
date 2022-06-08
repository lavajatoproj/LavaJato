//
//  CustomRowTableViewCell.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 12/03/22.
//

import UIKit

protocol CustomRowTableViewCellDelegate:AnyObject{
    func updateCustomRowCell(index:IndexPath,product:Services2)
}

class CustomRowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var serviceSwitch: UISwitch!
    @IBOutlet weak var houseSwitch: UISwitch!
    @IBOutlet weak var goHouseSwitch: UISwitch!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var haveLocationSwitch: UISwitch!
    
    static let identifier:String = "CustomRowTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    private weak var delegate:CustomRowTableViewCellDelegate?
    
    public func delegate(delegate:CustomRowTableViewCellDelegate?){
        self.delegate = delegate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.contentView.layer.cornerRadius = 15
        self.priceTextField.delegate = self
    }
    
    public func setupCell(product:Services2){
        self.productLabel.text = product.service
        self.serviceSwitch.isOn = product.value
        self.houseSwitch.isOn = product.house
        self.priceTextField.text = product.price
    }
    
    @IBAction func tappedValueSwitch(_ sender: UISwitch) {
        guard let cell = sender.next(CustomRowTableViewCell.self), let indexPath = cell.indexPath else { return}
        self.delegate?.updateCustomRowCell(index: indexPath, product: Services2(value: sender.isOn, house: self.houseSwitch.isOn, service: self.productLabel.text ?? "", price: self.priceTextField.text ?? ""))
    }
    
    @IBAction func tappedHouseSwitch(_ sender: UISwitch) {
        guard let cell = sender.next(CustomRowTableViewCell.self), let indexPath = cell.indexPath else { return}
        self.delegate?.updateCustomRowCell(index: indexPath, product: Services2(value: self.serviceSwitch.isOn, house: sender.isOn, service: self.productLabel.text ?? "", price: self.priceTextField.text ?? ""))
    }
    
    
}

extension CustomRowTableViewCell:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let cell = textField.next(CustomRowTableViewCell.self), let indexPath = cell.indexPath else { return}
        self.delegate?.updateCustomRowCell(index: indexPath, product: Services2(value: self.serviceSwitch.isOn, house: self.houseSwitch.isOn, service: self.productLabel.text ?? "", price: self.priceTextField.text ?? ""))
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
