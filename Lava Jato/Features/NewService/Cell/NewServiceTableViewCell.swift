//
//  NewServiceTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 15/05/22.
//

import UIKit
import FirebaseFirestore


class NewServiceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backColorView: UIView!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    
    static let identifier:String = "NewServiceCell"
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configStart()
    }
    
    func configStart(){
        self.backColorView.layer.cornerRadius = 15
        self.pictureImageView.contentMode = .scaleAspectFill
        self.pictureImageView.layer.cornerRadius = pictureImageView.frame.height / 2
        self.pictureImageView.clipsToBounds = true
    }
    
    public func setupCell(data:Professionals){
        self.nameLabel.text = data.userName
        self.pictureImageView.image = data.userImage
    }

    
}

