//
//  listaDeServicosViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit
import FirebaseFirestore

class listOfProfessionalsViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var background2View: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
//    private var listViewModel:ListViewModel = ListViewModel()
    private var infos: Users?
    var firestore: Firestore?
    var users: [Dictionary<String, Any>] = []
    
    
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
                    self.users.append(data)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.listViewModel.fetchHistory()
//        self.listViewModel.delegate(delegate: self)
        self.firestore = Firestore.firestore()
        self.setup()
        self.configItems()
        self.searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.listOfUsers()
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

extension listOfProfessionalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCustomCell? = tableView.dequeueReusableCell(withIdentifier: MyCustomCell.identifier, for: indexPath) as? MyCustomCell
        
        let user = self.users[indexPath.row]
        let name  = user["name"] as? String
//        if let url = user["url"] as? String{
//            cell?.pictureImageView.sd_setImage(with: URL(string: url), completed: nil)
//        }
        
        cell?.nameLabel.text = name
        
//        cell?.setupCell(data: self.listViewModel.loadUsers(indexPath: indexPath))
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedRow = self.listViewModel.loadUsers(indexPath: indexPath)
        let user = self.users[indexPath.row]
        performSegue(withIdentifier: "requestService", sender: user)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension listOfProfessionalsViewController: UISearchBarDelegate{
    
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
