//
//  profileTableViewCell.swift
//  ExercicioCustomTableViewBF
//
//  Created by Brendon Sambatti on 10/03/22.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var xibView: UIView!
    @IBOutlet weak var backgroundXib: UIView!
    
    static let identifier:String = "ServiceTableViewCell"
        static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundXib.layer.cornerRadius = 15.0
    }
    public func data(profile:Profile){
        self.nameLabel.text = profile.name
        self.userImage.image = profile.photo
        self.numberLabel.text = profile.number
        self.adressLabel.text = profile.adress
        self.requestLabel.text = profile.request
        self.serviceLabel.text = profile.service
    }
    public func dataService(profileService:ProfileService){
        self.nameLabel.text = profileService.name
        self.userImage.image = profileService.photo
        self.numberLabel.text = profileService.number
        self.adressLabel.text = profileService.adress
        self.requestLabel.text = profileService.request
        self.serviceLabel.text = profileService.service
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
