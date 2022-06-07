//
//  FiltroViewController.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 13/03/22.
//

import UIKit

protocol FilterViewControllerDelegate:AnyObject{
    func resultFilter(professionalMen:Bool,professionalFemale:Bool,currentPriceMin:Double,currentPriceMax:Double)
}

class FilterViewController: UIViewController{
    
    @IBOutlet weak var callMapsButton: UIButton!
    @IBOutlet weak var tViewTableView: UITableView!
    
    
    private weak var delegate:FilterViewControllerDelegate?
    
    public func delegate(delegate:FilterViewControllerDelegate?){
        self.delegate = delegate
    }
    
    private var viewModel:FilterViewModel
    
    var nameCity:String?
    var profMan:Bool?
    var profWon:Bool?
    var priceLimit:String?
//    var placeService
    
    //Falta o Type e tambem a localidade
    init?(professionalMen:Bool,professionalFemale:Bool,currentPriceMin:Double,currentPriceMax:Double, coder: NSCoder){
        self.viewModel = FilterViewModel(professionalMen: professionalMen, professionalFemale: professionalFemale,currentPriceMin:currentPriceMin,currentPriceMax: currentPriceMax)
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTView()
        self.navigationController?.navigationBar.tintColor = UIColor.ColorDefault
    }
    
    @IBAction func tappedCallMaps(_ sender: UIButton) {
        performSegue(withIdentifier: "maps", sender: nil)
//        print(self.priceLimit as Any)
    }
    
    // MARK: - Signatures
    
    func settingsTView(){
        self.tViewTableView.delegate = self
        self.tViewTableView.dataSource = self
        self.tViewTableView.register(GenderTableViewCell.nib(), forCellReuseIdentifier: GenderTableViewCell.identifier)
        self.tViewTableView.register(PriceTableViewCell.nib(), forCellReuseIdentifier: PriceTableViewCell.identifier)
    }
}

// MARK: - Extension

extension FilterViewController:UITableViewDelegate{}
extension FilterViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.countArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.identifier, for: indexPath) as? GenderTableViewCell
            cell?.setupCell(profile: self.viewModel.getGender)
            cell?.delegate(delegate: self)
            return cell ?? UITableViewCell()
        } else {
            let cellV = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.identifier, for: indexPath) as? PriceTableViewCell
            cellV?.setupCell(setup: self.viewModel.getPrice)
            cellV?.delegate(delegate: self)
            return cellV ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.loadHeighForRow(indexPath: indexPath)
    }
    
}

extension FilterViewController:GenderTableViewCellDelegate{
    func tappedSwitch(stateM: Bool, stateF: Bool) {
        self.viewModel.setStateSexo(stateM: stateM, stateF: stateF)
    }
}

extension FilterViewController:PriceTableViewCellDelegate{
    func result(priceMin: Double, priceMax: Double, type: String) {
        self.viewModel.setResult(priceMin: priceMin, priceMax: priceMax, type: type)
        self.delegate?.resultFilter(professionalMen: self.viewModel.getProfessionalMen, professionalFemale: self.viewModel.getProfessionalFemale, currentPriceMin: self.viewModel.getCurrentPriceMin, currentPriceMax: self.viewModel.getCurrentPriceMax)
        self.navigationController?.popViewController(animated: true)
    }
}
