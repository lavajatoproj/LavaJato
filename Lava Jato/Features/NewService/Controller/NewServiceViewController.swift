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
    
    
    private var newServiceViewModel:NewServiceViewModel = NewServiceViewModel()
    //    private var listViewModel:ListViewModel = ListViewModel()
    private var infos: Users?
    var firestore: Firestore?
    var users: [Dictionary<String, Any>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firestore = Firestore.firestore()
        self.setup()
        self.configItems()
        self.searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.listOfUsers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.newServiceViewModel.getFireBaseData()
    }
    
    
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
                for document in snapshot.documents {
                    let data = document.data()
                    let servers = data["server"]
                    if servers as? Int == 1{
                        self.users.append(data)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
   
    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "requestService"{
            let viewDestine = segue.destination as? requestServiceViewController
            
            viewDestine?.user = sender as? Dictionary
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
    
    @objc private func tapFilter(){
        performSegue(withIdentifier: "filter", sender: nil)
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
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewServiceTableViewCell? = tableView.dequeueReusableCell(withIdentifier: NewServiceTableViewCell.identifier, for: indexPath) as? NewServiceTableViewCell
        cell?.setupCell(data: newServiceViewModel.professionals[indexPath.row])
        
        
        
//
//        let user = self.users[indexPath.row]
//
//        let name  = user["name"] as? String
//        if let url = user["profileImage"] as? String{
//            cell?.pictureImageView.sd_setImage(with: URL(string: url), completed: nil)
//        }else{
//            cell?.pictureImageView.image = UIImage(systemName: "person.circle.fill")
//        }
//
//        cell?.nameLabel.text = name
        
        //        cell?.setupCell(data: self.listViewModel.loadUsers(indexPath: indexPath))
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let selectedRow = self.listViewModel.loadUsers(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        let user = self.users[indexPath.row]
        performSegue(withIdentifier: "requestService", sender: user)
    }
    
}

extension NewServiceViewController: UISearchBarDelegate{
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
























//
//    @IBOutlet weak var searchSearchBar: UISearchBar!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var tableView: UITableView!
//
//    private var newServiceViewModel:NewServiceViewModel = NewServiceViewModel()
//    private var infos: Users?
//
//
//    private var arrayNames2:[Professionals] = [
//        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Thiago", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: false, airPurification: false, sanitation: true)]),
//        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Bruno", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: false, washPolishing: false, dryWash: false, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
//        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Olivia", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
//        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Fred", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: true, ecoWash: false, airPurification: false, sanitation: true)]),
//        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Joao", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: true, washPolishing: true, dryWash: true, steamWash: true, ecoWash: true, airPurification: true, sanitation: true)])
//
//    ]
//
//    public var filterArray:[Professionals] = []
//
//    func setup(){
////        searchTextField.leftViewMode = UITextField.ViewMode.always
//        let search = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
//        let image = UIImage.init(systemName: "magnifyingglass")
//        search.image = image
//        let searchView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
//        searchView.addSubview(search)
////        searchTextField.leftView = searchView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setup()
//        self.configItems()
//        self.configtableView()
//    }
//
//    @objc private func tapFilter(){
//        performSegue(withIdentifier: "filter", sender: nil)
//    }
//
//    private func configtableView(){
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//        self.tableView.register(UINib(nibName: "NewServiceCell", bundle: nil), forCellReuseIdentifier: "NewServiceCell")
//    }
//
//    func configItems(){
//        self.navigationController?.navigationBar.tintColor = UIColor.ColorDefault
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(named: "filter"),
//            style: .done,
//            target: self,
//            action: #selector(tapFilter)
//        )
//    }
//}
//
//
//extension NewServiceViewController: NewServiceViewModelDelegate{
//
//    func success() {
//        self.setup()
//        tableView.reloadData()
//    }
//
//    func error() {
//        print(#function)
//    }
//}
//
//
//
//extension NewServiceViewController:UITableViewDataSource,UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return newServiceViewModel.countElements
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: MyCustomCell? = tableView.dequeueReusableCell(withIdentifier: MyCustomCell.identifier, for: indexPath) as? MyCustomCell
////        cell?.setUpCell(professionals:filterArray[indexPath.row])
////        cell?.setupCell(data: self.newServiceViewModel.loadUsers(indexPath: indexPath))
//        return cell ?? UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedRow = self.newServiceViewModel.loadUsers(indexPath: indexPath)
//        performSegue(withIdentifier: "requestService", sender: selectedRow)
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
//}
//
//
//
//


