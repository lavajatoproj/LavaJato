//
//  NewServiceTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 15/05/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorageUI

class NewServiceTableViewCell: UITableViewCell {


    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var backGroundView: UIView!
    
    static let identifier:String = "NewServiceTableViewCell"
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    var user: Dictionary<String, Any>?
    var auth: Auth?
    var firestore: Firestore?
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configStart()
    }
    
    func configStart(){
        self.pictureImageView.contentMode = .scaleAspectFill
        self.pictureImageView.layer.cornerRadius = pictureImageView.frame.height / 2
        self.pictureImageView.clipsToBounds = true
        self.backGroundView.layer.cornerRadius = 10
    }
    
    public func setupCell(data:Professionals){
        if data.userImage != ""{
            self.pictureImageView.sd_setImage(with: URL(string: data.userImage), completed: nil)
        }else{
            pictureImageView.image = UIImage(systemName: "person.circle.fill")
        }
        self.nameLabel.text = data.userName

    }    
}

