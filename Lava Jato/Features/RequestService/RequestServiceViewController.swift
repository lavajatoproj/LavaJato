//
//  solicitacaoViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorageUI

class RequestServiceViewController: UIViewController {
    
    @IBOutlet weak var background1ImageView: UIImageView!
    @IBOutlet weak var background2View: UIView!
    @IBOutlet weak var professionalImageView: UIImageView!
    @IBOutlet weak var nameProfessionalLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var service1Label: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var EndButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:RequestViewModel = RequestViewModel()
    var idUser:String?
    
    var user: Dictionary<String, Any>?
    var auth: Auth?
    var firestore: Firestore?
    
    var dataValue:Bool?
    var dataHouse:Bool?
    var dataPrice:String?
    var dataService:String?
    
    var dataValue1:Bool?
    var dataHouse1:Bool?
    var dataPrice1:String?
    var dataService1:String?
    
    var dataValue2:Bool?
    var dataHouse2:Bool?
    var dataPrice2:String?
    var dataService2:String?
    
    var dataValue3:Bool?
    var dataHouse3:Bool?
    var dataPrice3:String?
    var dataService3:String?
    
    var dataValue4:Bool?
    var dataHouse4:Bool?
    var dataPrice4:String?
    var dataService4:String?
    
    var dataValue5:Bool?
    var dataHouse5:Bool?
    var dataPrice5:String?
    var dataService5:String?
    
    var dataValue6:Bool?
    var dataHouse6:Bool?
    var dataPrice6:String?
    var dataService6:String?
    
    var dataValue7:Bool?
    var dataHouse7:Bool?
    var dataPrice7:String?
    var dataService7:String?
    
    
    private var alert:AlertController?
    
    func configInitials(){}
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.configTableView()
        self.addService()
        self.EndButton.layer.cornerRadius = 10
        self.houseLabel.text = "-"
        self.serviceLabel.text = "-"
        self.professionalImageView.contentMode = .scaleAspectFill
        self.professionalImageView.layer.cornerRadius = professionalImageView.frame.height / 2
        self.professionalImageView.clipsToBounds = true
        self.idUser = user?["id"] as? String
        if let name = user?["name"] as? String{
            self.nameProfessionalLabel.text = name
        }
        if let url = user?["profileImage"] as? String{
            self.professionalImageView.sd_setImage(with: URL(string: url), completed: nil)
        }
        self.getData()
        self.getData1()
        self.getData2()
        self.getData3()
        self.getData4()
        self.getData5()
        self.getData6()
        self.getData7()
    }
    
    func getData(){
        let data = self.firestore?.collection("lavagemSimples").document(self.idUser ?? "")
        data?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                self.dataValue = data?["value"] as? Bool
                self.dataHouse = data?["house"] as? Bool
                self.dataPrice = data?["price"] as? String
                self.dataService = data?["service"] as? String
            }
        })
    }
    
    func getData1(){
        let data = self.firestore?.collection("lavagemCompleta").document(self.idUser ?? "")
        data?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                self.dataValue1 = data?["value1"] as? Bool
                self.dataHouse1 = data?["house1"] as? Bool
                self.dataPrice1 = data?["price1"] as? String
                self.dataService1 = data?["service1"] as? String
            }
        })
    }
    
    func getData2(){
        let data = self.firestore?.collection("lavagemPolimento").document(self.idUser ?? "")
        data?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                self.dataValue2 = data?["value2"] as? Bool
                self.dataHouse2 = data?["house2"] as? Bool
                self.dataPrice2 = data?["price2"] as? String
                self.dataService2 = data?["service2"] as? String
            }
        })
    }
    
    func getData3(){
        let data = self.firestore?.collection("lavagemSeco").document(self.idUser ?? "")
        data?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                self.dataValue3 = data?["value3"] as? Bool
                self.dataHouse3 = data?["house3"] as? Bool
                self.dataPrice3 = data?["price3"] as? String
                self.dataService3 = data?["service3"] as? String
            }
        })
    }
    
    func getData4(){
        let data = self.firestore?.collection("lavagemVapor").document(self.idUser ?? "")
        data?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                self.dataValue4 = data?["value4"] as? Bool
                self.dataHouse4 = data?["house4"] as? Bool
                self.dataPrice4 = data?["price4"] as? String
                self.dataService4 = data?["service4"] as? String
            }
        })
    }
    
    func getData5(){
        let data = self.firestore?.collection("ecolavagem").document(self.idUser ?? "")
        data?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                self.dataValue5 = data?["value5"] as? Bool
                self.dataHouse5 = data?["house5"] as? Bool
                self.dataPrice5 = data?["price5"] as? String
                self.dataService5 = data?["service5"] as? String
            }
        })
    }
    
    func getData6(){
        let data = self.firestore?.collection("purificacao").document(self.idUser ?? "")
        data?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                self.dataValue6 = data?["value6"] as? Bool
                self.dataHouse6 = data?["house6"] as? Bool
                self.dataPrice6 = data?["price6"] as? String
                self.dataService6 = data?["service6"] as? String
            }
        })
    }
    
    func getData7(){
        let data = self.firestore?.collection("higienizacao").document(self.idUser ?? "")
        data?.getDocument(completion: { documentSnapshot, error in
            if error == nil{
                let data = documentSnapshot?.data()
                self.dataValue7 = data?["value7"] as? Bool
                self.dataHouse7 = data?["house7"] as? Bool
                self.dataPrice7 = data?["price7"] as? String
                self.dataService7 = data?["service7"] as? String
            }
        })
    }
    
//    func instantiateVC(){
//        let selectionVC = UIStoryboard(name: "PaymmentViewController", bundle: nil).instantiateViewController(withIdentifier: "PaymmentViewController") as? PaymmentViewController
//        selectionVC?.modalPresentationStyle =  .popover
//        self.present(selectionVC ?? UIViewController(), animated: true, completion: nil)
//    }
        
//        func tappedEndButton(_ sender: UIButton) {
//            self.serviceLabel.text = "-"
//            self.valueLabel.text = "-"
//            instantiateVC()
//            self.alert?.showAlert(title: "Você será redirecionado para o MercadoPago", message: "Após concluir o pagamento, você receberá um email de confirmação", titleButton: "Confirmar", completion: { value in
//                switch value {
//                case .aceitar:
//                    self.dismiss(animated: true)
//                case .cancel:
//                    let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
//                    let vC = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
//                    self.navigationController?.pushViewController(vC, animated: true)
//                }
//            })
//        }
    
    
    @IBAction func tappedRequestButton(_ sender: UIButton) {
        self.serviceLabel.text = "-"
        self.houseLabel.text = "-"
        self.performSegue(withIdentifier: "PaymmentViewController", sender: nil)
//        self.alert?.showAlert(title: "Você será redirecionado para o MercadoPago", message: "Após concluir o pagamento, você receberá um email de confirmação", titleButton: "Confirmar", completion: { value in
//            switch value {
//            case .aceitar:
//                self.performSegue(withIdentifier: "PaymmentViewController", sender: nil)
//            case .cancel:
//                print("Cancelado")
//            }
//        })
    }
    
    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CellTableViewCell.nib(), forCellReuseIdentifier: CellTableViewCell.identifier)
        self.tableView.register(Cell2TableViewCell.nib(), forCellReuseIdentifier: Cell2TableViewCell.identifier)
    }
    
    func addService(){
        self.viewModel.listService()
    }
    
    func Style(){
        let textAtributes = [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
        navigationController?.navigationBar.titleTextAttributes = textAtributes
    }
}

extension RequestServiceViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.listServices[section].opened == true{
            return self.viewModel.listServices[section].service.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2{
            let cell2 = tableView.dequeueReusableCell(withIdentifier: Cell2TableViewCell.identifier, for: indexPath) as? Cell2TableViewCell
            return cell2 ?? UITableViewCell()
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: CellTableViewCell.identifier, for: indexPath) as? CellTableViewCell
            
            if indexPath.row == 0{
                cell?.setupCell(product: self.viewModel.listServices[indexPath.section].title)
                cell?.productLabel.textAlignment = .center
                cell?.back2View.layer.borderWidth = 0.0
                cell?.arrowImageView.isHidden = false
                return cell ?? UITableViewCell()
            }else{
                cell?.setupCell(product: self.viewModel.listServices[indexPath.section].service[indexPath.row])
                cell?.productLabel.textAlignment = .left
                cell?.back2View.layer.borderWidth = 2.0
                cell?.back2View.layer.borderColor = UIColor.ColorDefault.cgColor
                cell?.arrowImageView.isHidden = true
                return cell ?? UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2{
            return 200
        }else{
            return 80
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
        
//            if indexPath.section == 0{
//                self.serviceLabel.text = self.viewModel.listServices[indexPath.section].service[indexPath.row]
//            }
        
        
        if indexPath.section == 0 && indexPath.row == 1{
            self.priceLabel.text = self.dataPrice
            self.serviceLabel.text = self.dataService
            self.houseLabel.text = ""
        } else if indexPath.section == 0 && indexPath.row == 2{
            self.priceLabel.text = self.dataPrice1
            self.serviceLabel.text = self.dataService1
            self.houseLabel.text = ""
        } else if indexPath.section == 0 && indexPath.row == 3{
            self.priceLabel.text = self.dataPrice2
            self.serviceLabel.text = self.dataService2
            self.houseLabel.text = ""
        } else if indexPath.section == 0 && indexPath.row == 4{
            self.priceLabel.text = self.dataPrice3
            self.serviceLabel.text = self.dataService3
            self.houseLabel.text = ""
        }else if indexPath.section == 0 && indexPath.row == 5{
            self.priceLabel.text = self.dataPrice4
            self.serviceLabel.text = self.dataService4
            self.houseLabel.text = ""
        }else if indexPath.section == 0 && indexPath.row == 6{
            self.priceLabel.text = self.dataPrice5
            self.serviceLabel.text = self.dataService5
            self.houseLabel.text = ""
        }else if indexPath.section == 0 && indexPath.row == 7{
            self.priceLabel.text = self.dataPrice6
            self.serviceLabel.text = self.dataService6
            self.houseLabel.text = ""
        }else if indexPath.section == 0 && indexPath.row == 8{
            self.priceLabel.text = self.dataPrice7
            self.serviceLabel.text = self.dataService7
            self.houseLabel.text = ""
        }
        
        if indexPath.section == 1 && indexPath.row != 0{
                self.houseLabel.text = self.viewModel.listServices[indexPath.section].service[indexPath.row]
            }
            
        }
}
