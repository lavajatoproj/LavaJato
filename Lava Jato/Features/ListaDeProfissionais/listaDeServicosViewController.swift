//
//  listaDeServicosViewController.swift
//  Lava Jato
//
//  Created by Luiz Claudio Mattos da Silva on 03/03/22.
//

import UIKit

class listaDeServicosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayNomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCustomCell? = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as? MyCustomCell
        
        cell?.fotoImageView.image = UIImage(named: self.arrayNomes[indexPath.row])
        cell?.nomeLabel.text = self.arrayNomes[indexPath.row]
        cell?.notaLabel.text = self.arrayNotas[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = self.arrayNomes[indexPath.row]
        performSegue(withIdentifier: "solicitacaoDeServico", sender: selectedRow)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var background2View: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titulo2Label: UILabel!
        
    private var arrayNomes:[String] = ["Claudio Mattos", "Brendon Oliveira", "Thiago Valentim", "Olímpio Junior", "Caio Fabrini", "Lucas Munho"]
    private var arrayNotas:[String] = ["5.0", "4.8", "4.7", "4.7", "4.4", "4.3"]
    
    func setup(){
        searchTextField.leftViewMode = UITextField.ViewMode.always
        let search = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        let image = UIImage.init(systemName: "magnifyingglass")
        search.image = image
        let searchView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        searchView.addSubview(search)
        searchTextField.leftView = searchView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureItems()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UINib(nibName: "MyCustomCell", bundle: nil), forCellReuseIdentifier: "MyCustomCell")
        
    }
    
    @objc private func tapFilter(){
        performSegue(withIdentifier: "filter", sender: nil)
    }
    
    
    func configureItems(){
        self.navigationController?.navigationBar.tintColor = UIColor.ColorDefault
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "filter"),
            style: .done,
            target: self,
            action: #selector(tapFilter)
        )
    }
    
}
