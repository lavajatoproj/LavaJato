//
//  NewServiceTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 15/05/22.
//

import UIKit

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
    }
    
    public func setupCell(data:RegisterUser){
        self.nameLabel.text = data.name
        self.noteLabel.text = data.note
    }
    
}

