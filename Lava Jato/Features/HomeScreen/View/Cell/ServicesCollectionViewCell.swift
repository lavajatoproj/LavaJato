//
//  ServicoCollectionViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 12/03/22.
//
import UIKit

class ServicesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var nameServiceLabel: UILabel!
    
    static let identifier:String = "ServicesCollectionViewCell"
    static func nib()->UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.desingMyCell()
    }
    
    func setup(with service:Service){
        serviceImageView.image = service.image
        nameServiceLabel.text = service.title
    }
    
    func desingMyCell(){
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
    }
}


