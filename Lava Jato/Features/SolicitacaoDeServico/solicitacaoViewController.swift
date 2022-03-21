//
//  solicitacaoViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit

class solicitacaoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listMarca[section].opened == true{
        return self.listMarca[section].produto.count
        }else{
            return 1
        }
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellTableViewCell.identifier, for: indexPath) as? cellTableViewCell
            cell?.setupCell(product: self.listMarca[indexPath.section].marca)
            cell?.productLabel.textAlignment = .center
            cell?.back2View.layer.borderWidth = 0.0
            cell?.arrowImageView.isHidden = false
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTableViewCell.identifier, for: indexPath) as? cellTableViewCell
            cell?.setupCell(product: self.listMarca[indexPath.section].produto[indexPath.row])
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
        if listMarca[indexPath.section].opened == true{
            listMarca[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }else{
            listMarca[indexPath.section].opened = true
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
                self.servicoLabel.text = "Lavagem Simples"
                self.valorLabel.text = "R$ 80,00"
            }else{
                if indexPath.row == 2{
                    self.servicoLabel.text = "Lavagem Completa"
                    self.valorLabel.text = "R$ 120,00"
                }else{
                    if indexPath.row == 3{
                        self.servicoLabel.text = "Lavagem + Polimento"
                        self.valorLabel.text = "R$ 250,00"
                    }else{
                        if indexPath.row == 4{
                            self.servicoLabel.text = "Lavagem a seco"
                            self.valorLabel.text = "R$ 130,00"
                        }else{
                            if indexPath.row == 5{
                                self.servicoLabel.text = "Lavagem a vapor"
                                self.valorLabel.text = "R$ 180,00"
                            }else{
                                if indexPath.row == 6{
                                    self.servicoLabel.text = "Variação: Ecolavagem"
                                    self.valorLabel.text = "R$ 170,00"
                                }else{
                                    if indexPath.row == 7{
                                        self.servicoLabel.text = "Purificação de ar"
                                        self.valorLabel.text = "R$ 140,00"
                                    }else{
                                        if indexPath.row == 8{
                                            self.servicoLabel.text = "Higienização"
                                            self.valorLabel.text = "R$ 90,00"
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
    
    
    @IBOutlet weak var background1ImageView: UIImageView!
    @IBOutlet weak var background2View: UIView!
    @IBOutlet weak var professionalImageView: UIImageView!
    @IBOutlet weak var nameProfessionalLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var servico1Label: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var servicoLabel: UILabel!
    @IBOutlet weak var valorLabel: UILabel!
    @IBOutlet weak var tappedContratar: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var listMarca:[Marca] =  []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tappedContratar.layer.cornerRadius = 10
        self.valorLabel.text = "-"
        self.servicoLabel.text = "-"
        self.configTableView()
        self.addMarca()
        
        Style()
    }
    
    @IBAction func tappedContratar(_ sender: UIButton) {
        self.servicoLabel.text = "-"
        self.valorLabel.text = "-"
    }
    
    
    private func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cellTableViewCell.nib(), forCellReuseIdentifier: cellTableViewCell.identifier)
    }
    
    private func addMarca(){
        self.listMarca.append(Marca(opened: false,marca: "Selecione o serviço", produto: ["","Lavagem Simples", "Lavagem Completa", "Lavagem + Polimento","Lavagem a seco","Lavagem a vapor","Variação: Ecolavagem","Purificação de ar","Higienização"]))
        self.listMarca.append(Marca(opened: false, marca: "Modo de retirada", produto: ["","Levarei ao local", "Buscar aqui"]))
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
    
    
    
    
    

}
