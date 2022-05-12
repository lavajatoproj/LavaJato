//
//  ValorTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 16/03/22.
//

import UIKit

class PriceTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var selectSlider: UISlider!
    @IBOutlet weak var priceMin: UILabel!
    @IBOutlet weak var priceMax: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var bannetCollectionView: UICollectionView!
    
    
    static let identifier:String = "PriceTableViewCell"
    static func nib()->UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        //Espaçamento entre cell
        flowLayout.minimumLineSpacing = 1.0
        bannetCollectionView.collectionViewLayout = flowLayout
        //Register
        bannetCollectionView.register(UINib(nibName: "PlaceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlaceCollectionViewCell")
        bannetCollectionView.dataSource = self
    }
    
    
    @IBAction func selectSlider(_ sender: UISlider) {
        let choose = Int(sender.value)
        self.priceMax.text = "R$\(choose),00"
    }
    
    public func setupCell(setup:ProfilePrice){
        self.priceLabel.text = setup.price
        self.priceMin.text = setup.priceMin
        self.priceMax.text = setup.priceMax
        self.placeLabel.text = setup.place
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPlace.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCollectionViewCell", for: indexPath) as! PlaceCollectionViewCell
        cellC.setupCell(with: dataPlace[indexPath.row])
        return cellC
    }
}









