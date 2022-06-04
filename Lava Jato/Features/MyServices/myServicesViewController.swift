//
//  meusServicosViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class myServicesViewController: UIViewController{
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var background2: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upDateButton: UIButton!
    
    private var viewModel:ServiceViewModel = ServiceViewModel()
    private var alert:AlertController?
    var auth: Auth?
    var firestore: Firestore?
    var serverInfo:String?
    
    var servicePrice:String = "80,00"
    var serviceValue:Bool = false
    var serviceHouse:Bool = false
    
    var servicePrice1:String = "80,00"
    var serviceValue1:Bool = false
    var serviceHouse1:Bool = false
    
    var servicePrice2:String = "80,00"
    var serviceValue2:Bool = false
    var serviceHouse2:Bool = false
    
    var servicePrice3:String = "80,00"
    var serviceValue3:Bool = false
    var serviceHouse3:Bool = false
    
    var servicePrice4:String = "80,00"
    var serviceValue4:Bool = false
    var serviceHouse4:Bool = false
    
    var servicePrice5:String = "80,00"
    var serviceValue5:Bool = false
    var serviceHouse5:Bool = false
    
    var servicePrice6:String = "80,00"
    var serviceValue6:Bool = false
    var serviceHouse6:Bool = false
    
    var servicePrice7:String = "80,00"
    var serviceValue7:Bool = false
    var serviceHouse7:Bool = false
    
    private func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CustomRowTableViewCell.nib(), forCellReuseIdentifier: CustomRowTableViewCell.identifier)
    }
    
    func configInitials(){
        self.upDateButton.layer.cornerRadius = 10
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configInitials()
        self.addServices()
        self.configTableView()
        self.alert = AlertController(controller: self)
    }
    
    @IBAction func tappedUpDateButton(_ sender: UIButton) {
    
            if let userLog = self.auth?.currentUser{

                let idUser = userLog.uid
                
                self.firestore?.collection("server")
                    .document(idUser)
                    .collection("lavagemSimples")
                    .addDocument(data: [
                        "service": "Lavagem Simples",
                        "price": self.servicePrice,
                        "value": self.serviceValue,
                        "house": self.serviceHouse
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("server")
                    .document(idUser)
                    .collection("lavagemCompleta")
                    .addDocument(data: [
                        "service": "Lavagem Completa",
                        "price": self.servicePrice1,
                        "value": self.serviceValue1,
                        "house": self.serviceHouse1
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("server")
                    .document(idUser)
                    .collection("lavagemPolimento")
                    .addDocument(data: [
                        "service": "Lavagem + Polimento",
                        "price": self.servicePrice2,
                        "value": self.serviceValue2,
                        "house": self.serviceHouse2
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("server")
                    .document(idUser)
                    .collection("lavagemSeco")
                    .addDocument(data: [
                        "service": "Lavagem a seco",
                        "price": self.servicePrice3,
                        "value": self.serviceValue3,
                        "house": self.serviceHouse3
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("server")
                    .document(idUser)
                    .collection("lavagemVapor")
                    .addDocument(data: [
                        "service": "Lavagem a vapor",
                        "price": self.servicePrice4,
                        "value": self.serviceValue4,
                        "house": self.serviceHouse4
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("server")
                    .document(idUser)
                    .collection("ecolavagem")
                    .addDocument(data: [
                        "service": "Variação: Ecolavagem",
                        "price": self.servicePrice5,
                        "value": self.serviceValue5,
                        "house": self.serviceHouse5
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("server")
                    .document(idUser)
                    .collection("purificacao")
                    .addDocument(data: [
                        "service": "Purificação de ar",
                        "price": self.servicePrice6,
                        "value": self.serviceValue6,
                        "house": self.serviceHouse6
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("server")
                    .document(idUser)
                    .collection("higienizacao")
                    .addDocument(data: [
                        "service": "Higienização",
                        "price": self.servicePrice7,
                        "value": self.serviceValue7,
                        "house": self.serviceHouse7
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
            }
        
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
            
            if index.row == 0{
                self.servicePrice = product.price
                self.serviceValue = product.value
                self.serviceHouse = product.house
            } else if index.row == 1{
                self.servicePrice1 = product.price
                self.serviceValue1 = product.value
                self.serviceHouse1 = product.house
            } else if index.row == 2{
                self.servicePrice2 = product.price
                self.serviceValue2 = product.value
                self.serviceHouse2 = product.house
            } else if index.row == 3{
                self.servicePrice3 = product.price
                self.serviceValue3 = product.value
                self.serviceHouse3 = product.house
            } else if index.row == 4{
                self.servicePrice4 = product.price
                self.serviceValue4 = product.value
                self.serviceHouse4 = product.house
            } else if index.row == 5{
                self.servicePrice5 = product.price
                self.serviceValue5 = product.value
                self.serviceHouse5 = product.house
            } else if index.row == 6{
                self.servicePrice6 = product.price
                self.serviceValue6 = product.value
                self.serviceHouse6 = product.house
            } else if index.row == 7{
                self.servicePrice7 = product.price
                self.serviceValue7 = product.value
                self.serviceHouse7 = product.house
            }
    }
}
