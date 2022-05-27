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
    
    
    
    func confIniciais(){
        self.fundoView.layer.cornerRadius = 15
    }

    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        confIniciais()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
