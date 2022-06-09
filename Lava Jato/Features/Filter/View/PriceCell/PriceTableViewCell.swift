//
//  ValorTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 16/03/22.
//

import UIKit

protocol PriceTableViewCellDelegate:AnyObject{
    func result(priceMin:Double,priceMax:Double,serviceHome:Bool, serviceLocal:Bool, takeService:Bool)
    func clean()
}

class PriceTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var priceMinTextField: UITextField!
    @IBOutlet weak var priceMaxTextField: UITextField!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var bannetCollectionView: UICollectionView!
    @IBOutlet weak var viewResultButton: UIButton!
    @IBOutlet weak var cleanResultButton: UIButton!
    
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
        bannetCollectionView.register(UINib(nibName: "PlaceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlaceCollectionViewCell")
        self.configCell()
        bannetCollectionView.dataSource = self
        self.priceMaxTextField.delegate = self
        self.priceMinTextField.delegate = self
        self.bannetCollectionView.delegate = self
    }
    
    
    private func configCell(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 200, height: 200)
        flowLayout.minimumLineSpacing = 1.0
        bannetCollectionView.collectionViewLayout = flowLayout
    }
    
    private var dataPlace: [ProfileBanner] = []
    
    @IBAction func tappedViewResultButton(_ sender: UIButton) {
        self.delegate?.result(priceMin: Double(self.priceMinTextField.text ?? "") ?? 0.0, priceMax: Double(self.priceMaxTextField.text ?? "") ?? 0.0, serviceHome: dataPlace[1].isSelect,serviceLocal: dataPlace[2].isSelect, takeService: dataPlace[0].isSelect)
    }
    
    @IBAction func tappedCleanResultButton(_ sender: UIButton) {
        self.delegate?.clean()
    }
    
    
    public func setupCell(setup:ProfilePrice,listProfileBanner:[ProfileBanner]){
        self.priceMinTextField.text = String(setup.currentPriceMin)
        self.priceMaxTextField.text = String(setup.currentPriceMax)
        self.dataPlace = listProfileBanner
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataPlace.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCollectionViewCell", for: indexPath) as? PlaceCollectionViewCell
        cellC?.setupCell(with: dataPlace[indexPath.row])
        return cellC ?? UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (index, _) in dataPlace.enumerated(){
            if index == indexPath.row{
                dataPlace[index].isSelect = !dataPlace[index].isSelect
            }
        }
        collectionView.reloadData()
    }
}

extension PriceTableViewCell:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}









