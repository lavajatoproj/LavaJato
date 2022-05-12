//
//  solicitacaoViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit

class requestServiceViewController: UIViewController {
    
    @IBOutlet weak var background1ImageView: UIImageView!
    @IBOutlet weak var background2View: UIView!
    @IBOutlet weak var professionalImageView: UIImageView!
    @IBOutlet weak var nameProfessionalLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var service1Label: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var EndButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:RequestViewModel = RequestViewModel()
    
    private var alert:AlertController?
    
    func configInitials(){
        self.EndButton.layer.cornerRadius = 10
        self.valueLabel.text = "-"
        self.serviceLabel.text = "-"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configInitials()
        self.configTableView()
        self.addService()
        self.alert = AlertController(controller: self)
        self.Style()
    }
    
    @IBAction func tappedEndButton(_ sender: UIButton) {
        self.serviceLabel.text = "-"
        self.valueLabel.text = "-"
        self.alert?.showAlert(title: "Você será redirecionado para o MercadoPago", message: "Após concluir o pagamento, você receberá um email de confirmação", titleButton: "Confirmar", completion: { value in
            switch value {
            case .aceitar:
                self.dismiss(animated: true)
            case .cancel:
                let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
                let vC = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
                self.navigationController?.pushViewController(vC, animated: true)
            }
        })
    }
    
    
    private func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellTableViewCell.nib(), forCellReuseIdentifier: cellTableViewCell.identifier)
    }
    
    private func addService(){
        self.viewModel.listService()
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
}

extension requestServiceViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.listServices[section].opened == true{
            return self.viewModel.listServices[section].service.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTableViewCell.identifier, for: indexPath) as? cellTableViewCell
            cell?.setupCell(product: self.viewModel.listServices[indexPath.section].title)
            cell?.productLabel.textAlignment = .center
            cell?.back2View.layer.borderWidth = 0.0
            cell?.arrowImageView.isHidden = false
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTableViewCell.identifier, for: indexPath) as? cellTableViewCell
            cell?.setupCell(product: self.viewModel.listServices[indexPath.section].service[indexPath.row])
            cell?.productLabel.textAlignment = .left
            cell?.back2View.layer.borderWidth = 2.0
            cell?.back2View.layer.borderColor = UIColor.ColorDefault.cgColor
            cell?.arrowImageView.isHidden = true
            
            
            return cell ?? UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
        }
        
        if indexPath.section == 0 && indexPath.row != 0{
            self.valueLabel.text = self.viewModel.listServices[indexPath.section].price[indexPath.row]
        }
    }
}


