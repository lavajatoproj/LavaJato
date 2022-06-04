//
//  NewServiceViewController.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 11/05/22.
//

import UIKit

class NewServiceViewController: UIViewController {

    
    @IBOutlet weak var searchSearchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private var newServiceViewModel:NewServiceViewModel = NewServiceViewModel()
    private var infos: Users?

    
    private var arrayNames2:[Professionals] = [
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Thiago", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: false, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Bruno", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: false, washPolishing: false, dryWash: false, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Olivia", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Fred", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: true, ecoWash: false, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Joao", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: true, washPolishing: true, dryWash: true, steamWash: true, ecoWash: true, airPurification: true, sanitation: true)])

    ]
    
    public var filterArray:[Professionals] = []
    
    func setup(){
//        searchTextField.leftViewMode = UITextField.ViewMode.always
        let search = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let image = UIImage.init(systemName: "magnifyingglass")
        search.image = image
        let searchView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        searchView.addSubview(search)
//        searchTextField.leftView = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.configItems()
        self.configtableView()
    }
    
    @objc private func tapFilter(){
        performSegue(withIdentifier: "filter", sender: nil)
    }
    
    private func configtableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "NewServiceCell", bundle: nil), forCellReuseIdentifier: "NewServiceCell")
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


extension NewServiceViewController: NewServiceViewModelDelegate{

    func success() {
        self.setup()
        tableView.reloadData()
    }
    
    func error() {
        print(#function)
    }
}



extension NewServiceViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newServiceViewModel.countElements
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCustomCell? = tableView.dequeueReusableCell(withIdentifier: MyCustomCell.identifier, for: indexPath) as? MyCustomCell
//        cell?.setUpCell(professionals:filterArray[indexPath.row])
//        cell?.setupCell(data: self.newServiceViewModel.loadUsers(indexPath: indexPath))
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = self.newServiceViewModel.loadUsers(indexPath: indexPath)
        performSegue(withIdentifier: "requestService", sender: selectedRow)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}



 


