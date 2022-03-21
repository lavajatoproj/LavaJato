//
//  profileTableViewCell.swift
//  ExercicioCustomTableViewBF
//
//  Created by Brendon Sambatti on 10/03/22.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var xibView: UIView!
    @IBOutlet weak var backgroundXib: UIView!
    
    static let identifier:String = "NotificationTableViewCell"
    
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundXib.layer.cornerRadius = 15.0
    }
    
    public func dados(profile:Profile){
        self.nameLabel.text = profile.name
        self.userImage.image = profile.photo
        self.numberLabel.text = profile.number
        self.adressLabel.text = profile.adress
        self.requestLabel.text = profile.request
        self.serviceLabel.text = profile.service
        self.paymentLabel.text = profile.payment
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
