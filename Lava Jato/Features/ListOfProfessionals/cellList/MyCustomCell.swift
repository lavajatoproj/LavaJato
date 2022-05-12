//
//  MyCustomCell.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit

class MyCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var fundoView: UIView!
    @IBOutlet weak var fotoImageView: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var notaLabel: UILabel!
    @IBOutlet weak var estrelaImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        confIniciais()
    }
    
    
    func confIniciais(){
        self.fundoView.layer.cornerRadius = 15
    }
 
    
    func setUpCell(professionals:Professionals){
        fotoImageView.image = professionals.userImage
        nomeLabel.text = professionals.userName
        notaLabel.text = String(professionals.userRate)
    }
}

