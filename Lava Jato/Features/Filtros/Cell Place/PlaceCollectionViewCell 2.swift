//
//  PlaceCollectionViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 21/03/22.
//

import UIKit

class PlaceCollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setupCell(with profilePlace:ProfileBanner){
        self.bannerImageView.image = profilePlace.imgA
       
    }

}
