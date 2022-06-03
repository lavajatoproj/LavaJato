//
//  meusServicosViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit

class myServicesViewController: UIViewController{
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var background2: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upDateButton: UIButton!
    
    private var viewModel:ServiceViewModel = ServiceViewModel()
    private var alert:AlertController?
    
    private func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CustomRowTableViewCell.nib(), forCellReuseIdentifier: CustomRowTableViewCell.identifier)
    }
    
    func configInitials(){
        self.upDateButton.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configInitials()
        self.addServices()
        self.configTableView()
        self.alert = AlertController(controller: self)
    }
    
    @IBAction func tappedUpDateButton(_ sender: UIButton) {
        print(self.viewModel.listServices)
//        self.alert?.showAlert(title: "Tem certeza que deseja atualizar?", message: "", titleButton: "Confirmar", completion: { value in
//            switch value {
//            case .aceitar:
//                let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
//                let vC = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
//                self.navigationController?.pushViewController(vC, animated: true)
//            case .cancel:
//                let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
//                let vC = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
//                self.navigationController?.pushViewController(vC, animated: true)
//            }
//        })
    }
    
    private func addServices(){
        self.viewModel.list()
    }
}


extension myServicesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomRowTableViewCell.identifier, for: indexPath) as? CustomRowTableViewCell
//        cell?.serviceSwitch.isHidden = false
//        cell?.houseSwitch.isHidden = false
        cell?.setupCell(product: self.viewModel.listServices[indexPath.row])
        cell?.delegate(delegate: self)
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listServices.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        156
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension myServicesViewController:CustomRowTableViewCellDelegate{
    func updateCustomRowCell(index: IndexPath, product: Services2) {
        self.viewModel.changeService(index: index, product: product)
    }
}
