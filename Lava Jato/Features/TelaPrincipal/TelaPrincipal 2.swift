//
//  TelaPrincipal.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 18/02/22.
//


import UIKit

class TelaPrincipal: UIViewController, UICollectionViewDelegate{

    // link CollectionView a ViewController
    @IBOutlet weak var cvCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        Style()
        // Subscriptions
        cvCollectionView.dataSource = self
        cvCollectionView.delegate = self
    }
    
    func Style(){
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
    }
}


extension TelaPrincipal:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return servico.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"ServicoCollectionViewCell", for:indexPath) as! ServicoCollectionViewCell
        // chamando a funcao de configuracao das bordas
        cell.setup(with: servico[indexPath.row])
        cell.desingMyCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let storyboard = UIStoryboard(name: "listaDeServicos", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listaDeServicos")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 1 {
            let storyboard = UIStoryboard(name: "listaDeServicos", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listaDeServicos")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 2 {
            let storyboard = UIStoryboard(name: "listaDeServicos", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listaDeServicos")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 3 {
            let storyboard = UIStoryboard(name: "listaDeServicos", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listaDeServicos")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 4 {
            let storyboard = UIStoryboard(name: "listaDeServicos", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listaDeServicos")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 5 {
            let storyboard = UIStoryboard(name: "listaDeServicos", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listaDeServicos")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 6 {
            let storyboard = UIStoryboard(name: "listaDeServicos", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listaDeServicos")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 7 {
            let storyboard = UIStoryboard(name: "listaDeServicos", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listaDeServicos")
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}


// Configurando o whidt e o hidth de cada celula
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // a funcao espera um retorno do tipo CGSize
        // de acordo com o width e o height que ira apresentar quantas linhas tera a colletion.
//        let size = (collectionView.frame.size.width - 8) / 2
        return CGSize (width: 152, height:141)
    }
}



extension UIView {
    func desingMyCell(){
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
//        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}

// funcao para mostrar o nome quando se clica na imagem
//extension ViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//  // ira imprimir o nome
//        print(servico[indexPath.row])
//    }
//}




