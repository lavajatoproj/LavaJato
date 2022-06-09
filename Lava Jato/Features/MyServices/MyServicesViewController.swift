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

class MyServicesViewController: UIViewController{
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var background2: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upDateButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    private var viewModel:ServiceViewModel = ServiceViewModel()
    private var alert:AlertController?
    var auth: Auth?
    var firestore: Firestore?
    var idUserLog:String?
    var serverInfo:String?
    
    var servicePrice:String = "80,00"
    var serviceValue:Bool = false
    var serviceHouse:Bool = false
    var serviceGoInHouse:Bool = false
    var serviceHaveLocation:Bool = false
    
    var servicePrice1:String = "80,00"
    var serviceValue1:Bool = false
    var serviceHouse1:Bool = false
    var serviceGoInHouse1:Bool = false
    var serviceHaveLocation1:Bool = false
    
    var servicePrice2:String = "80,00"
    var serviceValue2:Bool = false
    var serviceHouse2:Bool = false
    var serviceGoInHouse2:Bool = false
    var serviceHaveLocation2:Bool = false
    
    var servicePrice3:String = "80,00"
    var serviceValue3:Bool = false
    var serviceHouse3:Bool = false
    var serviceGoInHouse3:Bool = false
    var serviceHaveLocation3:Bool = false
    
    var servicePrice4:String = "80,00"
    var serviceValue4:Bool = false
    var serviceHouse4:Bool = false
    var serviceGoInHouse4:Bool = false
    var serviceHaveLocation4:Bool = false
    
    var servicePrice5:String = "80,00"
    var serviceValue5:Bool = false
    var serviceHouse5:Bool = false
    var serviceGoInHouse5:Bool = false
    var serviceHaveLocation5:Bool = false
    
    var servicePrice6:String = "80,00"
    var serviceValue6:Bool = false
    var serviceHouse6:Bool = false
    var serviceGoInHouse6:Bool = false
    var serviceHaveLocation6:Bool = false
    
    var servicePrice7:String = "80,00"
    var serviceValue7:Bool = false
    var serviceHouse7:Bool = false
    var serviceGoInHouse7:Bool = false
    var serviceHaveLocation7:Bool = false
    
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
    
    var nameData:String?
    var numberData:String?
    var emailData:String?
    var cepData:String?
    var adressData:String?
    var adressNumberData:String?
    var bornData:String?
    var documentData:String?
    var stateData:String?
    var genderData:String?
    var cityData:String?
    var id:String?
    var url:String?
    var profileImage:String?
    
    func getProfileData(){
        let user = self.firestore?.collection("users").document(self.idUserLog ?? "")
        user?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                self.id = data?["id"] as? String
                self.nameData = data?["name"] as? String
                self.nameLabel.text = self.nameData
                self.numberData = data?["cellNumber"] as? String
                self.emailData = data?["email"] as? String
                self.cepData = data?["cep"] as? String
                self.adressData = data?["adress"] as? String
                self.adressNumberData = data?["numberAdress"] as? String
                self.cityData = data?["city"] as? String
                self.cityLabel.text = self.cityData
                self.bornData = data?["born"] as? String
                self.documentData = data?["document"] as? String
                self.stateData = data?["state"] as? String
                self.genderData = data?["gender"] as? String
                self.url = data?["profileImage"] as? String
                self.profileImage = self.url
                if self.profileImage == self.url{
                    self.userImageView.sd_setImage(with: URL(string: self.url ?? ""), completed: nil)
                }else{
                    self.userImageView.image = UIImage(systemName: "person.circle.fill")
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
                    
                    if self.serviceValue == true{
                        self.firestore?.collection("lavagemSimples")
                            .document(idUser)
                            .setData([
                                "goInHouse": self.serviceGoInHouse,
                                "haveLocation": self.serviceHaveLocation,
                                "service": "Lavagem Simples",
                                "price": self.servicePrice,
                                "value": self.serviceValue,
                                "house": self.serviceHouse,
                                "nameData": self.nameData as Any,
                                "numberData": self.numberData as Any,
                                "emailData": self.emailData as Any,
                                "cepData": self.cepData as Any,
                                "adressData": self.adressData as Any,
                                "adressNumberData": self.adressNumberData as Any,
                                "bornData": self.bornData as Any,
                                "documentData": self.documentData as Any,
                                "stateData": self.stateData as Any,
                                "genderData": self.genderData as Any,
                                "cityData": self.cityData as Any,
                                "id": self.id as Any,
                                "profileImage": self.url as Any,
                            ]) { (error) in
                                if error == nil{
                                    print("deu bom")
                                }
                            }
                    }else{
                        self.firestore?.collection("lavagemSimples")
                            .document(idUser).delete()
                    }
                    
                    if self.serviceValue1 == true{
                        self.firestore?.collection("lavagemCompleta")
                            .document(idUser)
                            .setData([
                                "goInHouse": self.serviceGoInHouse1,
                                "haveLocation": self.serviceHaveLocation1,
                                "service": "Lavagem Completa",
                                "price": self.servicePrice1,
                                "value": self.serviceValue1,
                                "house": self.serviceHouse1,
                                "nameData": self.nameData as Any,
                                "numberData": self.numberData as Any,
                                "emailData": self.emailData as Any,
                                "cepData": self.cepData as Any,
                                "adressData": self.adressData as Any,
                                "adressNumberData": self.adressNumberData as Any,
                                "bornData": self.bornData as Any,
                                "documentData": self.documentData as Any,
                                "stateData": self.stateData as Any,
                                "genderData": self.genderData as Any,
                                "cityData": self.cityData as Any,
                                "id": self.id as Any,
                                "profileImage": self.url as Any,
                            ]) { (error) in
                                if error == nil{
                                    print("deu bom")
                                }
                            }
                    }else{
                        self.firestore?.collection("lavagemCompleta")
                            .document(idUser).delete()
                    }
                    
                    if self.serviceValue2 == true{
                        self.firestore?.collection("lavagemPolimento")
                            .document(idUser)
                            .setData([
                                "goInHouse": self.serviceGoInHouse2,
                                "haveLocation": self.serviceHaveLocation2,
                                "service": "Lavagem + Polimento",
                                "price": self.servicePrice2,
                                "value": self.serviceValue2,
                                "house": self.serviceHouse2,
                                "nameData": self.nameData as Any,
                                "numberData": self.numberData as Any,
                                "emailData": self.emailData as Any,
                                "cepData": self.cepData as Any,
                                "adressData": self.adressData as Any,
                                "adressNumberData": self.adressNumberData as Any,
                                "bornData": self.bornData as Any,
                                "documentData": self.documentData as Any,
                                "stateData": self.stateData as Any,
                                "genderData": self.genderData as Any,
                                "cityData": self.cityData as Any,
                                "id": self.id as Any,
                                "profileImage": self.url as Any,
                            ]) { (error) in
                                if error == nil{
                                    print("deu bom")
                                }
                            }
                    }else{
                        self.firestore?.collection("lavagemPolimento")
                            .document(idUser).delete()
                    }
                    
                    if self.serviceValue3 == true{
                        self.firestore?.collection("lavagemSeco")
                            .document(idUser)
                            .setData([
                                "goInHouse": self.serviceGoInHouse3,
                                "haveLocation": self.serviceHaveLocation3,
                                "service": "Lavagem a seco",
                                "price": self.servicePrice3,
                                "value": self.serviceValue3,
                                "house": self.serviceHouse3,
                                "nameData": self.nameData as Any,
                                "numberData": self.numberData as Any,
                                "emailData": self.emailData as Any,
                                "cepData": self.cepData as Any,
                                "adressData": self.adressData as Any,
                                "adressNumberData": self.adressNumberData as Any,
                                "bornData": self.bornData as Any,
                                "documentData": self.documentData as Any,
                                "stateData": self.stateData as Any,
                                "genderData": self.genderData as Any,
                                "cityData": self.cityData as Any,
                                "id": self.id as Any,
                                "profileImage": self.url as Any,
                            ]) { (error) in
                                if error == nil{
                                    print("deu bom")
                                }
                            }
                    }else{
                        self.firestore?.collection("lavagemSeco")
                            .document(idUser).delete()
                    }

                    if self.serviceValue4 == true{
                        self.firestore?.collection("lavagemVapor")
                            .document(idUser)
                            .setData([
                                "goInHouse": self.serviceGoInHouse4,
                                "haveLocation": self.serviceHaveLocation4,
                                "service": "Lavagem a vapor",
                                "price": self.servicePrice4,
                                "value": self.serviceValue4,
                                "house": self.serviceHouse4,
                                "nameData": self.nameData as Any,
                                "numberData": self.numberData as Any,
                                "emailData": self.emailData as Any,
                                "cepData": self.cepData as Any,
                                "adressData": self.adressData as Any,
                                "adressNumberData": self.adressNumberData as Any,
                                "bornData": self.bornData as Any,
                                "documentData": self.documentData as Any,
                                "stateData": self.stateData as Any,
                                "genderData": self.genderData as Any,
                                "cityData": self.cityData as Any,
                                "id": self.id as Any,
                                "profileImage": self.url as Any,
                            ]) { (error) in
                                if error == nil{
                                    print("deu bom")
                                }
                            }
                    }else{
                        self.firestore?.collection("lavagemVapor")
                            .document(idUser).delete()
                    }
                    
                    if self.serviceValue5 == true{
                        self.firestore?.collection("ecolavagem")
                            .document(idUser)
                            .setData([
                                "goInHouse": self.serviceGoInHouse5,
                                "haveLocation": self.serviceHaveLocation5,
                                "service": "Variação: Ecolavagem",
                                "price": self.servicePrice5,
                                "value": self.serviceValue5,
                                "house": self.serviceHouse5,
                                "nameData": self.nameData as Any,
                                "numberData": self.numberData as Any,
                                "emailData": self.emailData as Any,
                                "cepData": self.cepData as Any,
                                "adressData": self.adressData as Any,
                                "adressNumberData": self.adressNumberData as Any,
                                "bornData": self.bornData as Any,
                                "documentData": self.documentData as Any,
                                "stateData": self.stateData as Any,
                                "genderData": self.genderData as Any,
                                "cityData": self.cityData as Any,
                                "id": self.id as Any,
                                "profileImage": self.url as Any,
                            ]) { (error) in
                                if error == nil{
                                    print("deu bom")
                                }
                            }
                    }else{
                        self.firestore?.collection("ecolavagem")
                            .document(idUser).delete()
                    }
                    
                    if self.serviceValue6 == true{
                        self.firestore?.collection("purificacao")
                            .document(idUser)
                            .setData([
                                "goInHouse": self.serviceGoInHouse6,
                                "haveLocation": self.serviceHaveLocation6,
                                "service": "Purificação de ar",
                                "price": self.servicePrice6,
                                "value": self.serviceValue6,
                                "house": self.serviceHouse6,
                                "nameData": self.nameData as Any,
                                "numberData": self.numberData as Any,
                                "emailData": self.emailData as Any,
                                "cepData": self.cepData as Any,
                                "adressData": self.adressData as Any,
                                "adressNumberData": self.adressNumberData as Any,
                                "bornData": self.bornData as Any,
                                "documentData": self.documentData as Any,
                                "stateData": self.stateData as Any,
                                "genderData": self.genderData as Any,
                                "cityData": self.cityData as Any,
                                "id": self.id as Any,
                                "profileImage": self.url as Any,
                            ]) { (error) in
                                if error == nil{
                                    print("deu bom")
                                }
                            }
                    }else{
                        self.firestore?.collection("purificacao")
                            .document(idUser).delete()
                    }
                    
                    if self.serviceValue7 == true{
                        self.firestore?.collection("higienizacao")
                            .document(idUser)
                            .setData([
                                "goInHouse": self.serviceGoInHouse7,
                                "haveLocation": self.serviceHaveLocation7,
                                "service": "Higienização",
                                "price": self.servicePrice7,
                                "value": self.serviceValue7,
                                "house": self.serviceHouse7,
                                "nameData": self.nameData as Any,
                                "numberData": self.numberData as Any,
                                "emailData": self.emailData as Any,
                                "cepData": self.cepData as Any,
                                "adressData": self.adressData as Any,
                                "adressNumberData": self.adressNumberData as Any,
                                "bornData": self.bornData as Any,
                                "documentData": self.documentData as Any,
                                "stateData": self.stateData as Any,
                                "genderData": self.genderData as Any,
                                "cityData": self.cityData as Any,
                                "id": self.id as Any,
                                "profileImage": self.url as Any,
                            ]) { (error) in
                                if error == nil{
                                    print("deu bom")
                                }
                            }
                    }else{
                        self.firestore?.collection("higienizacao")
                            .document(idUser).delete()
                    }
                }
        
// MARK: - Comentado abaixo para testar o código em cima
        
        
//        if let userLog = self.auth?.currentUser{
//
//            let idUser = userLog.uid
//
////            if self.serviceValue == true{
//                self.firestore?.collection("lavagemSimples")
//                    .document(idUser)
//                    .setData([
//                        "service": "Lavagem Simples",
//                        "price": self.servicePrice,
//                        "value": self.serviceValue,
//                        "house": self.serviceHouse,
//                        "nameData": self.nameData as Any,
//                        "numberData": self.numberData as Any,
//                        "emailData": self.emailData as Any,
//                        "cepData": self.cepData as Any,
//                        "adressData": self.adressData as Any,
//                        "adressNumberData": self.adressNumberData as Any,
//                        "bornData": self.bornData as Any,
//                        "documentData": self.documentData as Any,
//                        "stateData": self.stateData as Any,
//                        "genderData": self.genderData as Any,
//                        "cityData": self.cityData as Any,
//                        "id": self.id as Any,
//                        "profileImage": self.url as Any,
//                    ]) { (error) in
//                        if error == nil{
//                            print("deu bom")
//                        }
//                    }
////            }else{
////                self.firestore?.collection("lavagemSimples")
////                    .document(idUser).delete()
////            }
//
////            if self.serviceValue1 == true{
//                self.firestore?.collection("lavagemCompleta")
//                    .document(idUser)
//                    .setData([
//                        "service1": "Lavagem Completa",
//                        "price1": self.servicePrice1,
//                        "value1": self.serviceValue1,
//                        "house1": self.serviceHouse1,
//                        "nameData": self.nameData as Any,
//                        "numberData": self.numberData as Any,
//                        "emailData": self.emailData as Any,
//                        "cepData": self.cepData as Any,
//                        "adressData": self.adressData as Any,
//                        "adressNumberData": self.adressNumberData as Any,
//                        "bornData": self.bornData as Any,
//                        "documentData": self.documentData as Any,
//                        "stateData": self.stateData as Any,
//                        "genderData": self.genderData as Any,
//                        "cityData": self.cityData as Any,
//                        "id": self.id as Any,
//                        "url": self.url as Any,
//                    ]) { (error) in
//                        if error == nil{
//                            print("deu bom")
//                        }
//                    }
////            }else{
////                self.firestore?.collection("lavagemCompleta")
////                    .document(idUser).delete()
////            }
//
////            if self.serviceValue2 == true{
//                self.firestore?.collection("lavagemPolimento")
//                    .document(idUser)
//                    .setData([
//                        "service2": "Lavagem + Polimento",
//                        "price2": self.servicePrice2,
//                        "value2": self.serviceValue2,
//                        "house2": self.serviceHouse2,
//                        "nameData": self.nameData as Any,
//                        "numberData": self.numberData as Any,
//                        "emailData": self.emailData as Any,
//                        "cepData": self.cepData as Any,
//                        "adressData": self.adressData as Any,
//                        "adressNumberData": self.adressNumberData as Any,
//                        "bornData": self.bornData as Any,
//                        "documentData": self.documentData as Any,
//                        "stateData": self.stateData as Any,
//                        "genderData": self.genderData as Any,
//                        "cityData": self.cityData as Any,
//                        "id": self.id as Any,
//                        "url": self.url as Any,
//                    ]) { (error) in
//                        if error == nil{
//                            print("deu bom")
//                        }
//                    }
////            }else{
////                self.firestore?.collection("lavagemPolimento")
////                    .document(idUser).delete()
////            }
//
////            if self.serviceValue3 == true{
//                self.firestore?.collection("lavagemSeco")
//                    .document(idUser)
//                    .setData([
//                        "service3": "Lavagem a seco",
//                        "price3": self.servicePrice3,
//                        "value3": self.serviceValue3,
//                        "house3": self.serviceHouse3,
//                        "nameData": self.nameData as Any,
//                        "numberData": self.numberData as Any,
//                        "emailData": self.emailData as Any,
//                        "cepData": self.cepData as Any,
//                        "adressData": self.adressData as Any,
//                        "adressNumberData": self.adressNumberData as Any,
//                        "bornData": self.bornData as Any,
//                        "documentData": self.documentData as Any,
//                        "stateData": self.stateData as Any,
//                        "genderData": self.genderData as Any,
//                        "cityData": self.cityData as Any,
//                        "id": self.id as Any,
//                        "url": self.url as Any,
//                    ]) { (error) in
//                        if error == nil{
//                            print("deu bom")
//                        }
//                    }
////            }else{
////                self.firestore?.collection("lavagemSeco")
////                    .document(idUser).delete()
////            }
////
////            if self.serviceValue4 == true{
//                self.firestore?.collection("lavagemVapor")
//                    .document(idUser)
//                    .setData([
//                        "service4": "Lavagem a vapor",
//                        "price4": self.servicePrice4,
//                        "value4": self.serviceValue4,
//                        "house4": self.serviceHouse4,
//                        "nameData": self.nameData as Any,
//                        "numberData": self.numberData as Any,
//                        "emailData": self.emailData as Any,
//                        "cepData": self.cepData as Any,
//                        "adressData": self.adressData as Any,
//                        "adressNumberData": self.adressNumberData as Any,
//                        "bornData": self.bornData as Any,
//                        "documentData": self.documentData as Any,
//                        "stateData": self.stateData as Any,
//                        "genderData": self.genderData as Any,
//                        "cityData": self.cityData as Any,
//                        "id": self.id as Any,
//                        "url": self.url as Any,
//                    ]) { (error) in
//                        if error == nil{
//                            print("deu bom")
//                        }
//                    }
////            }else{
////                self.firestore?.collection("lavagemVapor")
////                    .document(idUser).delete()
////            }
//
////            if self.serviceValue5 == true{
//                self.firestore?.collection("ecolavagem")
//                    .document(idUser)
//                    .setData([
//                        "service5": "Variação: Ecolavagem",
//                        "price5": self.servicePrice5,
//                        "value5": self.serviceValue5,
//                        "house5": self.serviceHouse5,
//                        "nameData": self.nameData as Any,
//                        "numberData": self.numberData as Any,
//                        "emailData": self.emailData as Any,
//                        "cepData": self.cepData as Any,
//                        "adressData": self.adressData as Any,
//                        "adressNumberData": self.adressNumberData as Any,
//                        "bornData": self.bornData as Any,
//                        "documentData": self.documentData as Any,
//                        "stateData": self.stateData as Any,
//                        "genderData": self.genderData as Any,
//                        "cityData": self.cityData as Any,
//                        "id": self.id as Any,
//                        "url": self.url as Any,
//                    ]) { (error) in
//                        if error == nil{
//                            print("deu bom")
//                        }
//                    }
////            }else{
////                self.firestore?.collection("ecolavagem")
////                    .document(idUser).delete()
////            }
//
////            if self.serviceValue6 == true{
//                self.firestore?.collection("purificacao")
//                    .document(idUser)
//                    .setData([
//                        "service6": "Purificação de ar",
//                        "price6": self.servicePrice6,
//                        "value6": self.serviceValue6,
//                        "house6": self.serviceHouse6,
//                        "nameData": self.nameData as Any,
//                        "numberData": self.numberData as Any,
//                        "emailData": self.emailData as Any,
//                        "cepData": self.cepData as Any,
//                        "adressData": self.adressData as Any,
//                        "adressNumberData": self.adressNumberData as Any,
//                        "bornData": self.bornData as Any,
//                        "documentData": self.documentData as Any,
//                        "stateData": self.stateData as Any,
//                        "genderData": self.genderData as Any,
//                        "cityData": self.cityData as Any,
//                        "id": self.id as Any,
//                        "url": self.url as Any,
//                    ]) { (error) in
//                        if error == nil{
//                            print("deu bom")
//                        }
//                    }
////            }else{
////                self.firestore?.collection("purificacao")
////                    .document(idUser).delete()
////            }
//
////            if self.serviceValue7 == true{
//                self.firestore?.collection("higienizacao")
//                    .document(idUser)
//                    .setData([
//                        "service7": "Higienização",
//                        "price7": self.servicePrice7,
//                        "value7": self.serviceValue7,
//                        "house7": self.serviceHouse7,
//                        "nameData": self.nameData as Any,
//                        "numberData": self.numberData as Any,
//                        "emailData": self.emailData as Any,
//                        "cepData": self.cepData as Any,
//                        "adressData": self.adressData as Any,
//                        "adressNumberData": self.adressNumberData as Any,
//                        "bornData": self.bornData as Any,
//                        "documentData": self.documentData as Any,
//                        "stateData": self.stateData as Any,
//                        "genderData": self.genderData as Any,
//                        "cityData": self.cityData as Any,
//                        "id": self.id as Any,
//                        "url": self.url as Any,
//                    ]) { (error) in
//                        if error == nil{
//                            print("deu bom")
//                        }
//                    }
////            }else{
////                self.firestore?.collection("higienizacao")
////                    .document(idUser).delete()
////            }
//        }
//
//        //        self.alert?.showAlert(title: "Tem certeza que deseja atualizar?", message: "", titleButton: "Confirmar", completion: { value in
//        //            switch value {
//        //            case .aceitar:
//        //                let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
//        //                let vC = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
//        //                self.navigationController?.pushViewController(vC, animated: true)
//        //            case .cancel:
//        //                let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
//        //                let vC = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
//        //                self.navigationController?.pushViewController(vC, animated: true)
//        //            }
//        //        })
    }
    
    private func addServices(){
        self.viewModel.list()
    }
}


extension MyServicesViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        190
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MyServicesViewController:CustomRowTableViewCellDelegate{
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
