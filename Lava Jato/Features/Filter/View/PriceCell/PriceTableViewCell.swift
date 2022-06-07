//
//  ValorTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 16/03/22.
//

import UIKit

protocol PriceTableViewCellDelegate:AnyObject{
    func result(priceMin:Double,priceMax:Double,type:String)
}

class PriceTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var priceMinTextField: UITextField!
    @IBOutlet weak var priceMaxTextField: UITextField!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var bannetCollectionView: UICollectionView!
    @IBOutlet weak var viewResultButton: UIButton!
    
    private weak var delegate:PriceTableViewCellDelegate?
    
    public func delegate(delegate:PriceTableViewCellDelegate?){
        self.delegate = delegate
    }
    
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
        self.priceMaxTextField.delegate = self
        self.priceMinTextField.delegate = self
    }
    
    @IBAction func tappedViewResultButton(_ sender: UIButton) {
        self.delegate?.result(priceMin: Double(self.priceMinTextField.text ?? "") ?? 0.0, priceMax: Double(self.priceMaxTextField.text ?? "") ?? 0.0,type: "Tipo do servico")
    }
    
    public func setupCell(setup:ProfilePrice){
        self.priceMinTextField.text = String(setup.currentPriceMin)
        self.priceMaxTextField.text = String(setup.currentPriceMax)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPlace.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCollectionViewCell", for: indexPath) as? PlaceCollectionViewCell
        cellC?.setupCell(with: dataPlace[indexPath.row])
        return cellC ?? UICollectionViewCell()
    }
}

extension PriceTableViewCell:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}









