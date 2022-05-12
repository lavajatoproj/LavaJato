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
    
    var listServices:[Services] =  []
    private var alert:AlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.priceTF.isHidden = true
        self.valueLabel.text = "-"
        self.addServices()
        self.configTableView()
        self.upDateButton.layer.cornerRadius = 10
        self.alert = AlertController(controller: self)
    }
    
    @IBAction func tappedUpDateButton(_ sender: UIButton) {
        self.priceTF.isHidden=true
        self.serviceLabel.text = "-"
        self.valueLabel.text = "-"
        self.alert?.showAlert(title: "Tem certeza que deseja atualizar?", message: "", titleButton: "Confirmar", completion: { value in
            switch value {
            case .aceitar:
                let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
                let vC = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
                self.navigationController?.pushViewController(vC, animated: true)
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
        self.tableView.register(CustomRowTableViewCell.nib(), forCellReuseIdentifier: CustomRowTableViewCell.identifier)
    }
    
    private func addServices(){
        self.listServices.append(Services(opened: false, title: "Meus serviços", service: ["","Lavagem Simples", "Lavagem Completa", "Lavagem + Polimento","Lavagem a seco","Lavagem a vapor","Variação: Ecolavagem","Purificação de ar","Higienização"]))
        self.listServices.append(Services(opened: false, title: "Formas de serviço", service: ["","Busco em casa", "Atendo no local"]))
        self.listServices.append(Services(opened: false, title: "Preço", service: ["","Lavagem Simples", "Lavagem Completa", "Lavagem + Polimento","Lavagem a seco","Lavagem a vapor","Variação: Ecolavagem","Purificação de ar","Higienização"]))
    }
    
}


extension myServicesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomRowTableViewCell.identifier, for: indexPath) as? CustomRowTableViewCell
            cell?.setupCell(product: self.listServices[indexPath.section].title)
            cell?.productLabel.textAlignment = .center
            cell?.back2View.layer.borderWidth = 0.0
            cell?.arrowImageView.isHidden = false
            
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomRowTableViewCell.identifier, for: indexPath) as? CustomRowTableViewCell
            cell?.setupCell(product: self.listServices[indexPath.section].service[indexPath.row])
            cell?.switch.isHidden=false
            cell?.productLabel.textAlignment = .left
            cell?.back2View.layer.borderWidth = 2.0
            cell?.back2View.layer.borderColor = UIColor.ColorDefault.cgColor
            cell?.arrowImageView.isHidden = true
            
            if indexPath.section == 2{
                cell?.switch.isHidden = true
                    }
            
            return cell ?? UITableViewCell()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listServices.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listServices[section].opened == true{
            return self.listServices[section].service.count
        }else{
            return 1
        }
        
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
        
        if indexPath.section == 2{
            if indexPath.row == 1{
                self.serviceLabel.text = "Lavagem Simples"
                self.priceTF.isHidden = false
            }else{
                if indexPath.row == 2{
                    self.serviceLabel.text = "Lavagem Completa"
                    self.priceTF.isHidden = false
                }else{
                    if indexPath.row == 3{
                        self.serviceLabel.text = "Lavagem + Polimento"
                        self.priceTF.isHidden = false
                    }else{
                        if indexPath.row == 4{
                            self.serviceLabel.text = "Lavagem a seco"
                            self.priceTF.isHidden = false
                        }else{
                            if indexPath.row == 5{
                                self.serviceLabel.text = "Lavagem a vapor"
                                self.priceTF.isHidden = false
                            }else{
                                if indexPath.row == 6{
                                    self.serviceLabel.text = "Variação: Ecolavagem"
                                    self.priceTF.isHidden = false
                                }else{
                                    if indexPath.row == 7{
                                        self.serviceLabel.text = "Purificação de ar"
                                        self.priceTF.isHidden = false
                                    }else{
                                        if indexPath.row == 8{
                                            self.serviceLabel.text = "Higienização"
                                            self.priceTF.isHidden = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }else{
            self.priceTF.isHidden = true
        }
    }
    
    
    
    
}
