//
//  FiltroViewController.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 13/03/22.
//

import UIKit

class FilterViewController: UIViewController{
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var callMapsButton: UIButton!
    @IBOutlet weak var tViewTableView: UITableView!
    
    private var viewModel:FilterViewModel = FilterViewModel()
    
    var data:[ProfileGender] = [
        ProfileGender(nameM: "Profissionais homem", nameF: "Profissionais mulher"),
        ProfileGender(nameM: "Profissionais homem", nameF: "Profissionais mulher")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTView()
        self.viewModel.callFunc()
        self.navigationController?.navigationBar.tintColor = UIColor.ColorDefault
    }
    
    @IBAction func tappedCallMaps(_ sender: UIButton) {
        performSegue(withIdentifier: "maps", sender: nil)
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
        if self.viewModel.isFirstCell{
            return 1
        }
        return self.viewModel.coutArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.identifier, for: indexPath) as? GenderTableViewCell
//            self.viewModel.callFunc()
            cell?.setupCell(profile: self.viewModel.loadGender(indexPath: indexPath))
            
//            cell?.setupCell(profile: self.viewModel.loadGender(indexPath:indexPath))
       return cell ?? UITableViewCell()
        } else {
            let cellV = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.identifier, for: indexPath) as? PriceTableViewCell
//            self.viewModel.callFunc()
            cellV?.setupCell(setup: self.viewModel.loadPrice(indexPath:indexPath))
            return cellV ?? UITableViewCell()
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0{
//            return 166.0
//        } else 
//            return 466.0
//        }
//    }
}

