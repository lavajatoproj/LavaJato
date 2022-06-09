//
//  ValorTableViewCell.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 16/03/22.
//

import UIKit

protocol PriceTableViewCellDelegate:AnyObject{
    func result(priceMin:Double,priceMax:Double,type:String)
//    func clear(priceMin:Double,priceMax:Double,type:String)
}

class PriceTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var priceMinTextField: UITextField!
    @IBOutlet weak var priceMaxTextField: UITextField!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var bannetCollectionView: UICollectionView!
    @IBOutlet weak var viewResultButton: UIButton!
    @IBOutlet weak var cleanResultButton: UIButton!
    
    
    var getLocation:Int = 0
    
   
    
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
    
    @IBAction func tappedViewResultButton(_ sender: UIButton) {
        self.delegate?.result(priceMin: Double(self.priceMinTextField.text ?? "Digite o valor mínimo") ?? 0.0, priceMax: Double(self.priceMaxTextField.text ?? "Digite o valor máximo") ?? 0.0,type: "Tipo do servico")
    }
    
    @IBAction func tappedCleanResultButton(_ sender: UIButton) {
//        self.delegate?.clear(priceMin: 0.0, priceMax: 0.0, type: "")
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (index, value) in dataPlace.enumerated(){
            if index == indexPath.row{
                dataPlace[index].isSelect = true
            }else{
                dataPlace[index].isSelect = false
            }
        }
        
        collectionView.reloadData()
        
        if indexPath.item == 0 {
            self.getLocation = 1
            print(getLocation)
        }
        if indexPath.item == 1 {
            self.getLocation = 2
            print(getLocation)
        }
        if indexPath.item == 2 {
            self.getLocation = 3
            print(getLocation)
        }
    }
    

}

extension PriceTableViewCell:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}









