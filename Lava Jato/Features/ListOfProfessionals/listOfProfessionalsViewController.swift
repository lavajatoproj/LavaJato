//
//  listaDeServicosViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit

class listOfProfessionalsViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var background2View: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var listViewModel:ListViewModel = ListViewModel()
    private var infos: Users?
    
    
    func setup(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(MyCustomCell.nib(), forCellReuseIdentifier: MyCustomCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listViewModel.fetchHistory()
        self.listViewModel.delegate(delegate: self)
        self.setup()
        self.configItems()
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

extension listOfProfessionalsViewController: ListViewModelDelegate{

    func success() {
        self.setup()
        tableView.reloadData()
    }
    
    func error() {
        print(#function)
    }
    
}

extension listOfProfessionalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listViewModel.countElements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCustomCell? = tableView.dequeueReusableCell(withIdentifier: MyCustomCell.identifier, for: indexPath) as? MyCustomCell
        cell?.setupCell(data: self.listViewModel.loadUsers(indexPath: indexPath))
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = self.listViewModel.loadUsers(indexPath: indexPath)
        performSegue(withIdentifier: "requestService", sender: selectedRow)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
