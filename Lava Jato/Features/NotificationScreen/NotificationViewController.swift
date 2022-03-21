//
//  NotificationViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 14/03/22.
//

import UIKit

class NotificationViewController: UIViewController {
    
    //ligações da tableview e background
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroudView: UIImageView!
    
    //lista de notificações
    var data:[Profile] = [
        Profile(name: "Nome: Junyor", photo: UIImage(imageLiteralResourceName: "profile1"), adress: "Endereço: Rua numero, 2315 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Completa ", payment: "Tipo do Pagamento: Dinheiro"),
        Profile(name: "Nome: Brendon", photo: UIImage(imageLiteralResourceName: "profile2"), adress: "Endereço: Rua numero, 121 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Simples ", payment: "Tipo do Pagamento: Cartão de Débito"),
        Profile(name: "Nome: Thiago", photo: UIImage(imageLiteralResourceName: "profile3"), adress: "Endereço: Rua numero, 1123 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Polimento e Cristalização ", payment: "Tipo do Pagamento: PIX"),
        Profile(name: "Nome: Claudio", photo: UIImage(imageLiteralResourceName: "profile1"), adress: "Endereço: Rua numero, 2221 ", number: "Telefone: (11)99999-9999 ", request: "Data do Pedido: 29/12/2022", service: "Tipo do Serviço: Lavagem Simples ", payment: "Tipo do Pagamento: Cartão de Crédito")
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configTableView()
        self.backgroudView.layer.cornerRadius = 15.0
    }
    
//configurações e assinaturas da tableview
    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(NotificationTableViewCell.nib(), forCellReuseIdentifier: NotificationTableViewCell.identifier)
        self.tableView.layer.cornerRadius = 15.0
        self.tableView.backgroundColor = UIColor.clear
    }
    
    
}
//extensões da tableview
extension NotificationViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as? NotificationTableViewCell
        cell?.dados(profile: data[indexPath.row])
        cell?.xibView.layer.borderWidth = 0.0
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletAction = UIContextualAction(style: .destructive, title: nil){action, view, boolAction in
            //função de apagar as linhas
            self.data.remove(at: indexPath.row)
            tableView.performBatchUpdates{
                //deletar linhas
                tableView.deleteRows(at: [indexPath], with: .fade)
            } completion: { completed in
                //remocao completa
            }
        }
        //Adicionando imagem no swipe delete
        deletAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deletAction])
    }
}
//extensão delegate para a tableview
extension NotificationViewController:UITableViewDelegate{
    
}
