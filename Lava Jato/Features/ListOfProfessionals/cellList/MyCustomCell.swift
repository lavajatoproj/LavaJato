//
//  MyCustomCell.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit

class MyCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var backgrounddView: UIView!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    
    func confIniciais(){
        self.backgrounddView.layer.cornerRadius = 15
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        confIniciais()
        
    }

    public func setupCell(data:RegisterUser){
        self.nameLabel.text = data.name
        self.noteLabel.text = data.note
        self.pictureImageView.image = UIImage(named: data.iconImage ?? "person")
    }
    
}
