//
//  PlaceCollectionViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 21/03/22.
//

import UIKit

protocol PlaceCollectionViewCellDelegate:AnyObject{
    func chooseLocal(homeService:Bool, searchService:Bool, takeService:Bool )
}

class PlaceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    private weak var delegate:PlaceCollectionViewCellDelegate?
    public func delegate(delegate:PlaceCollectionViewCellDelegate?){
        self.delegate = delegate
    }
    
    static let indentifier:String = "PlaceCollectionViewCell"
    static func nib()->UINib{
        return UINib(nibName: self.indentifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()      
    }
    
    
    
    func setupCell(with profilePlace:ProfileBanner){
//        var selectCell:Bool = false
        self.bannerImageView.image = profilePlace.imgA
        if  profilePlace.isSelect{
            self.bannerImageView.layer.borderWidth = 1.5
            self.bannerImageView.layer.borderColor = UIColor.white.cgColor
//            selectCell = true
        }else{
            self.bannerImageView.layer.borderWidth = 0
//            selectCell = false
        }
       
        
        
    }
    

}


