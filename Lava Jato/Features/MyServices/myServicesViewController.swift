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
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var service1Label: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    private var viewModel:ServiceViewModel = ServiceViewModel()
    private var alert:AlertController?
    
    private func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CustomRowTableViewCell.nib(), forCellReuseIdentifier: CustomRowTableViewCell.identifier)
    }
    
    func configInitials(){
        self.upDateButton.layer.cornerRadius = 10
        self.valueLabel.text = "-"
        self.priceTF.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configInitials()
        self.addServices()
        self.configTableView()
        self.alert = AlertController(controller: self)
    }
    
    func tapped(){
        self.priceTF.isHidden=true
        self.serviceLabel.text = "-"
        self.valueLabel.text = "-"
    }
    
    @IBAction func tappedUpDateButton(_ sender: UIButton) {
        self.tapped()
        self.alert?.showAlert(title: "Tem certeza que deseja atualizar?", message: "", titleButton: "Confirmar", completion: { value in
            switch value {
            case .aceitar:
                print("atualizado")
            case .cancel:
                print("cancelado")
            }
        })
    }
    
    private func addServices(){
        self.viewModel.list()
    }
}


extension myServicesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomRowTableViewCell.identifier, for: indexPath) as? CustomRowTableViewCell
            cell?.setupCell(product: self.viewModel.listServices[indexPath.section].title)
            cell?.productLabel.textAlignment = .center
            cell?.back2View.layer.borderWidth = 0.0
            cell?.arrowImageView.isHidden = false
            
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomRowTableViewCell.identifier, for: indexPath) as? CustomRowTableViewCell
            cell?.setupCell(product: self.viewModel.listServices[indexPath.section].service[indexPath.row])
            cell?.productLabel.textAlignment = .left
            cell?.back2View.layer.borderWidth = 2.0
            cell?.back2View.layer.borderColor = UIColor.ColorDefault.cgColor
            cell?.arrowImageView.isHidden = true
            
            return cell ?? UITableViewCell()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.listServices.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.listServices[section].opened == true{
            return self.viewModel.listServices[section].service.count
        }else{
            return 1
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.listServices[indexPath.section].opened == true{
            viewModel.listServices[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }else{
            viewModel.listServices[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
        
        if indexPath.section == 0{
            self.serviceLabel.text = self.viewModel.listServices[indexPath.section].service[indexPath.row]
            self.valueLabel.text = self.viewModel.listServices[indexPath.section].price[indexPath.row]
        } else if indexPath.section == 2{
            self.serviceLabel.text = self.viewModel.listServices[indexPath.section].service[indexPath.row]
            self.priceTF.isHidden = false
        }else{
            self.priceTF.isHidden = true
        }
        
        if indexPath.section != 2 && indexPath.row != 0{
            self.alert?.showAlert(title: "Adicionar em atualizações", message: "", titleButton: "Confirmar", completion: { value in
                switch value {
                case .aceitar:
                    print("adicionado")
                case .cancel:
                    print("cancelado")
                }
            })
        }
        
    }
}
