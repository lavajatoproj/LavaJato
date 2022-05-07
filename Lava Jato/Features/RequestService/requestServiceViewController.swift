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
    
    var listServices:[Services] =  []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.EndButton.layer.cornerRadius = 10
        self.valueLabel.text = "-"
        self.serviceLabel.text = "-"
        self.configTableView()
        self.addService()
        
        Style()
    }
    
    @IBAction func tappedEndButton(_ sender: UIButton) {
        self.serviceLabel.text = "-"
        self.valueLabel.text = "-"
    }
    
    
    private func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellTableViewCell.nib(), forCellReuseIdentifier: cellTableViewCell.identifier)
    }
    
    private func addService(){
        self.listServices.append(Services(opened: false,title: "Selecione o serviço", service: ["","Lavagem Simples", "Lavagem Completa", "Lavagem + Polimento","Lavagem a seco","Lavagem a vapor","Variação: Ecolavagem","Purificação de ar","Higienização"]))
        self.listServices.append(Services(opened: false, title: "Modo de retirada", service: ["","Levarei ao local", "Buscar aqui"]))
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
        if listServices[section].opened == true{
        return self.listServices[section].service.count
        }else{
            return 1
        }
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTableViewCell.identifier, for: indexPath) as? cellTableViewCell
            cell?.setupCell(product: self.listServices[indexPath.section].title)
            cell?.productLabel.textAlignment = .center
            cell?.back2View.layer.borderWidth = 0.0
            cell?.arrowImageView.isHidden = false
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTableViewCell.identifier, for: indexPath) as? cellTableViewCell
            cell?.setupCell(product: self.listServices[indexPath.section].service[indexPath.row])
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
        if listServices[indexPath.section].opened == true{
            listServices[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }else{
            listServices[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
        
        if indexPath.section == 1{
            if indexPath.row == 1{
                
            }else{
                
            }
        }
        
        if indexPath.section == 0{
            if indexPath.row == 1{
                self.serviceLabel.text = "Lavagem Simples"
                self.valueLabel.text = "R$ 80,00"
            }else{
                if indexPath.row == 2{
                    self.serviceLabel.text = "Lavagem Completa"
                    self.valueLabel.text = "R$ 120,00"
                }else{
                    if indexPath.row == 3{
                        self.serviceLabel.text = "Lavagem + Polimento"
                        self.valueLabel.text = "R$ 250,00"
                    }else{
                        if indexPath.row == 4{
                            self.serviceLabel.text = "Lavagem a seco"
                            self.valueLabel.text = "R$ 130,00"
                        }else{
                            if indexPath.row == 5{
                                self.serviceLabel.text = "Lavagem a vapor"
                                self.valueLabel.text = "R$ 180,00"
                            }else{
                                if indexPath.row == 6{
                                    self.serviceLabel.text = "Variação: Ecolavagem"
                                    self.valueLabel.text = "R$ 170,00"
                                }else{
                                    if indexPath.row == 7{
                                        self.serviceLabel.text = "Purificação de ar"
                                        self.valueLabel.text = "R$ 140,00"
                                    }else{
                                        if indexPath.row == 8{
                                            self.serviceLabel.text = "Higienização"
                                            self.valueLabel.text = "R$ 90,00"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
    }
    
    
    
}
