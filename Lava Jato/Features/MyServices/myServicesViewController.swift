//
//  meusServicosViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorageUI

class myServicesViewController: UIViewController{
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var background2: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upDateButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var viewModel:ServiceViewModel = ServiceViewModel()
    private var alert:AlertController?
    var auth: Auth?
    var firestore: Firestore?
    var idUserLog:String?
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
    
    func getProfileData(){
        let user = self.firestore?.collection("users").document(self.idUserLog ?? "")
        user?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                let dataName = data?["name"]
                self.nameLabel.text = dataName as? String
                if let url = data?["profileImage"] as? String{
                    self.userImageView.sd_setImage(with: URL(string: url), completed: nil)
                }
                }
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configInitials()
        self.addServices()
        self.configTableView()
        self.alert = AlertController(controller: self)
        if let idUser = auth?.currentUser?.uid{
            self.idUserLog = idUser
        }
        self.userImageView.contentMode = .scaleAspectFill
        self.userImageView.layer.cornerRadius = userImageView.frame.height / 2
        self.userImageView.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getProfileData()
    }
    
    @IBAction func tappedUpDateButton(_ sender: UIButton) {
    
            if let userLog = self.auth?.currentUser{

                let idUser = userLog.uid
                
                self.firestore?.collection("lavagemSimples")
                    .document(idUser)
                    .setData([
                        "service": "Lavagem Simples",
                        "price": self.servicePrice,
                        "value": self.serviceValue,
                        "homeService": self.serviceHouse,
//                        "userImage": self.userImageView as Any,
                        "name": self.nameLabel.text
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("lavagemCompleta")
                    .document(idUser)
                    .setData([
                        "service1": "Lavagem Completa",
                        "price1": self.servicePrice1,
                        "value1": self.serviceValue1,
                        "house1": self.serviceHouse1,
                        "name1": nameLabel.text
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("lavagemPolimento")
                    .document(idUser)
                    .setData([
                        "service2": "Lavagem + Polimento",
                        "price2": self.servicePrice2,
                        "value2": self.serviceValue2,
                        "house2": self.serviceHouse2,
                        "name2": nameLabel.text
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("lavagemSeco")
                    .document(idUser)
                    .setData([
                        "service3": "Lavagem a seco",
                        "price3": self.servicePrice3,
                        "value3": self.serviceValue3,
                        "house3": self.serviceHouse3,
                        "name3": nameLabel.text
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("lavagemVapor")
                    .document(idUser)
                    .setData([
                        "service4": "Lavagem a vapor",
                        "price4": self.servicePrice4,
                        "value4": self.serviceValue4,
                        "house4": self.serviceHouse4,
                        "name4": nameLabel.text
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("ecolavagem")
                    .document(idUser)
                    .setData([
                        "service5": "Variação: Ecolavagem",
                        "price5": self.servicePrice5,
                        "value5": self.serviceValue5,
                        "house5": self.serviceHouse5,
                        "name5": nameLabel.text
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("purificacao")
                    .document(idUser)
                    .setData([
                        "service6": "Purificação de ar",
                        "price6": self.servicePrice6,
                        "value6": self.serviceValue6,
                        "house6": self.serviceHouse6,
                        "name6": nameLabel.text
                    ]) { (error) in
                        if error == nil{
                            print("deu bom")
                        }
                    }
                
                self.firestore?.collection("higienizacao")
                    .document(idUser)
                    .setData([
                        "service7": "Higienização",
                        "price7": self.servicePrice7,
                        "value7": self.serviceValue7,
                        "house7": self.serviceHouse7,
                        "name7": nameLabel.text
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
