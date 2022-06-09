//
//  listaDeServicosViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit
import FirebaseFirestore

class ListOfProfessionalsViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var background2View: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel:ListViewModel = ListViewModel()
    private var infos: Users?
    var firestore: Firestore?
    var users: [Dictionary<String, Any>] = []
    var serviceProviders:[Professionals] = []
    var listUserFilter:[Professionals] = []
    var professionals:Professionals?

    
    
    func setup(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(MyCustomCell.nib(), forCellReuseIdentifier: MyCustomCell.identifier)
    }
    
    func listOfUsers(){
        self.users.removeAll()
        self.tableView.reloadData()
        
        firestore?.collection("users").getDocuments{ snapshotResult, error in
            if let snapshot = snapshotResult{
                DispatchQueue.main.async {
                    self.serviceProviders = snapshot.documents.map({ document in
                        return Professionals(
                            userImage: document["profileImage"] as? String ?? "",
                            userName: document["name"] as? String ?? "",
                            id: document["id"] as? String ?? "",
                            price: document["price"] as? Double ?? 0.0,
                            homeService: document["house"] as? Bool ?? false,
                            serviceType: document["service"] as? String ?? "",
                            goToService: document["house"] as? Bool ?? false,
                            takeService: document["house"] as? Bool ?? false,
                            professionalGender: document["gender"] as? String ?? "",
                            localCity: document["city"] as? String ?? ""
                        )
                    })
                    print( self.serviceProviders)
                    self.listUserFilter = self.serviceProviders
                  //TO DO: Delegate
                    self.tableView.reloadData()
                }
//                for document in snapshot.documents {
//                    let data = document.data()
//                    let servers = data["server"]
//                    if servers as? Int == 1{
//                        self.users.append(data)
//                    }
//                }
//                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      self.listViewModel.fetchHistory()
//      self.listViewModel.delegate(delegate: self)
        self.firestore = Firestore.firestore()
        self.setup()
        self.configItems()
        self.searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.listOfUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RequestService"{
            let viewDestine = segue.destination as? RequestServiceViewController
            
            viewDestine?.userData = self.professionals
        }
    }
    
    func searchUsers(text: String ){
        let listFilter: [Dictionary<String, Any>] = self.users
        self.users.removeAll()
        
        for item in listFilter{
            if let name = item["name"] as? String{
                if name.lowercased().contains(text.lowercased()){
                    self.users.append(item)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    
    // MARK: - inicio da alteração
    @objc private func tapFilter(){
        let vc:FilterViewController? = UIStoryboard(name: "FilterViewController", bundle: nil).instantiateViewController(identifier: "FilterViewController") { coder -> FilterViewController? in
            return FilterViewController (professionalMen: self.viewModel.getProfessionalMen, professionalFemale: self.viewModel.getProfessionalFemale, currentPriceMin: self.viewModel.getCurrentPriceMin,currentPriceMax: self.viewModel.getCurrentPriceMax,currentHomeService: self.viewModel.getHomeService, currentTakeService: self.viewModel.getTakeService, currentGoToLocal: self.viewModel.getGoToService, coder: coder)
            
        }
        vc?.delegate(delegate: self)
        self.navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    //MARK: -  Fim da alteração
    
    
    
    func configItems(){
        self.navigationController?.navigationBar.tintColor = UIColor.ColorDefault
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "filter"),
            style: .done,
            target: self,
            action: #selector(tapFilter)
        )
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let vcRequest = segue.destination as? requestServiceViewController
    //        vcRequest?.nameProfessional = titleLabel.text ?? "salve"
    //    }
    
}

//extension listOfProfessionalsViewController: ListViewModelDelegate{
//
//    func success() {
//        self.setup()
//        tableView.reloadData()
//    }
//    
//    func error() {
//        print(#function)
//    }
//    
//}

extension ListOfProfessionalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listUserFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCustomCell? = tableView.dequeueReusableCell(withIdentifier: MyCustomCell.identifier, for: indexPath) as? MyCustomCell
        
        let user = self.listUserFilter[indexPath.row]
        let name = user.userName
        if let url = user.userImage as? String{
            cell?.pictureImageView.sd_setImage(with: URL(string: url), completed: nil)
        }else{
            cell?.pictureImageView.image = UIImage(systemName: "person.circle.fill")
        }
        
        cell?.nameLabel.text = name
        
        //        cell?.setupCell(data: self.listViewModel.loadUsers(indexPath: indexPath))
        
        return cell ?? UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let selectedRow = self.listViewModel.loadUsers(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        self.professionals = self.listUserFilter[indexPath.row]
        performSegue(withIdentifier: "RequestService", sender: self.professionals)
    }
    
}

extension ListOfProfessionalsViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let textSearch = searchBar.text{
            if textSearch != ""{
                searchUsers(text: textSearch )
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            listOfUsers()
        }
    }
}

// MARK: -  Criado extension para receber delegate
extension ListOfProfessionalsViewController:FilterViewControllerDelegate{
    
    func clearFilter() {
        self.viewModel.clearFilter()
    }
    
    func resultFilter(professionalMen: Bool, professionalFemale: Bool, currentPriceMin: Double, currentPriceMax: Double, homeService:Bool, takeService:Bool, goToService:Bool) {
        self.viewModel.setFilter(professionalMen: professionalMen, professionalFemale: professionalFemale, currentPriceMin: currentPriceMin, currentPriceMax: currentPriceMax, homeService: homeService, takeService: takeService, goToService: goToService )
        self.tableView.reloadData()
    }

}
