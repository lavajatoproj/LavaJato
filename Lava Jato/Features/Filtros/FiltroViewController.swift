//
//  FiltroViewController.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 13/03/22.
//

import UIKit

class FiltroViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
   

    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var callMapsButton: UIButton!
    @IBOutlet weak var tViewTableView: UITableView!
    
    // Array para popular cell Element
    var data:[ProfileGenre] = [
        ProfileGenre(nameM: "Profissionais homem", nameF: "Profissionais mulher"),
        ProfileGenre(nameM: "Profissionais homem", nameF: "Profissionais mulher")
  ]
    
    // Array para popular cell Price
    var listerPrice:[ProfilePrice] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTView()
        configPrice()
    }
    

    @IBAction func callMaps(_ sender: Any) {
        performSegue(withIdentifier: "maps", sender: nil)
    }
    // Método para popular cell
    
     
   // Assinaturas
    func settingsTView(){
        self.tViewTableView.delegate = self
        self.tViewTableView.dataSource = self
        self.tViewTableView.register(ElementTableViewCell.nib(), forCellReuseIdentifier: ElementTableViewCell.identifier)
        self.tViewTableView.register(PriceTableViewCell.nib(), forCellReuseIdentifier: PriceTableViewCell.identifier)
    }
    
    func configPrice(){
        self.listerPrice.append(ProfilePrice(price: "Valor do serviço", priceMin: "R$20,00", priceMax: "R$800,00", place: "Onde você prefere fazer o serviço?"));
        self.listerPrice.append(ProfilePrice(price: "Valor do serviço", priceMin: "R$20,00", priceMax: "R$800,00", place: "Onde você prefere fazer o serviço?"))
    }
    
    // MARK: - métodos / extension

    // Definindo o número de rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    // Populando as cell e definindo uma ordem
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ElementTableViewCell.identifier, for: indexPath) as? ElementTableViewCell
            cell?.setupCell(profile: data[indexPath.row])
            
            return cell ?? UITableViewCell()
        } else  {
            let cellV = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.identifier, for: indexPath) as? PriceTableViewCell
            cellV?.setupCell(setup: self.listerPrice[indexPath.row])

            return cellV ?? UITableViewCell()
        }
        
    }
    
//     Definindo heigh
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0{
            return 166.0
        } else {
            return 466.0
        }
    }
    
}
    
