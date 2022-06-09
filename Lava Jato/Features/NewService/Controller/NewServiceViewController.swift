//
//  NewServiceViewController.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 11/05/22.
//

import UIKit
import FirebaseFirestore

class NewServiceViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var serviceProviders:[Professionals] = []
    var typeWash:String
    var user:Professionals?
    
    private var viewModel:NewServiceViewModel = NewServiceViewModel()
    
    init?(typeWash:String, coder: NSCoder){
        self.typeWash = typeWash
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.configItems()
        self.searchBar.delegate = self
        self.viewModel.delegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.getFireBaseData(washType: typeWash)
    }
    
    func setup(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(NewServiceTableViewCell.nib(), forCellReuseIdentifier: NewServiceTableViewCell.identifier)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RequestService"{
            let viewDestine = segue.destination as? RequestServiceViewController
            viewDestine?.professionalsFilter = self.user
        }
    }
    
    @objc private func tapFilter(){
        let vc:FilterViewController? = UIStoryboard(name: "FilterViewController", bundle: nil).instantiateViewController(identifier: "FilterViewController") { coder -> FilterViewController? in
            return FilterViewController(professionalMen: self.viewModel.getProfessionalMen, professionalFemale: self.viewModel.getProfessionalFemale, currentPriceMin: self.viewModel.getCurrentPriceMin,currentPriceMax: self.viewModel.getCurrentPriceMax,currentHomeService: self.viewModel.getHomeService, currentTakeService: self.viewModel.getTakeService, currentGoToLocal: self.viewModel.getGoToService, coder: coder)
        }
        vc?.delegate(delegate: self)
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func configItems(){
        self.navigationController?.navigationBar.tintColor = UIColor.ColorDefault
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "filter"),
            style: .done,
            target: self,
            action: #selector(tapFilter)
        )
    }
}

extension NewServiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.countElemented
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewServiceTableViewCell? = tableView.dequeueReusableCell(withIdentifier: NewServiceTableViewCell.identifier, for: indexPath) as? NewServiceTableViewCell
        cell?.setupCell(data: self.viewModel.loudCurrentProfessional(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.user = self.viewModel.listUserFilter[indexPath.row]
//        print(user)
        performSegue(withIdentifier: "RequestService", sender: user)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.loadHeighForRow(indexPath: indexPath)
    }
    
}

extension NewServiceViewController: UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let textSearch = searchBar.text{
            self.viewModel.searchUsers(text: textSearch)
            self.tableView.reloadData()
        }
    }
}


extension NewServiceViewController:FilterViewControllerDelegate{    
    func resultFilter(professionalMen: Bool, professionalFemale: Bool, currentPriceMin: Double, currentPriceMax: Double, homeService:Bool, takeService:Bool, goToService:Bool) {
        self.viewModel.setFilter(professionalMen: professionalMen, professionalFemale: professionalFemale, currentPriceMin: currentPriceMin, currentPriceMax: currentPriceMax, homeService: homeService, takeService: takeService, goToService: goToService )
        self.tableView.reloadData()
    }
    
    
//    func clearFilter(professionalMen: Bool, professionalFemale: Bool, currentPriceMin: Double, currentPriceMax: Double) {
//        self.viewModel.setFilter(professionalMen: professionalMen, professionalFemale: professionalFemale, currentPriceMin: currentPriceMin, currentPriceMax: currentPriceMax)
//        self.tableView.reloadData()
//    }
    
    
}

extension NewServiceViewController:NewServiceViewModelDelegate{
    func success() {
        
    }
    
    func error() {
        
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
