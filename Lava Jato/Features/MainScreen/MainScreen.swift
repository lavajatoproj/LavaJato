//
//  MainScreen.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 18/02/22.
//


import UIKit

class MainScreen: UIViewController {
    
    @IBOutlet weak var cvCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingCV()
        
    }
    
    // MARK: Signatures
    
    func settingCV(){
        self.Style()
        cvCollectionView.dataSource = self
        cvCollectionView.delegate = self
        self.cvCollectionView.register(ServicesCollectionViewCell.nib(), forCellWithReuseIdentifier: ServicesCollectionViewCell.identifier)
    }
    
    func Style(){
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor:UIColor.ColorDefault]
    }
}

// MARK: Extension
extension MainScreen:UICollectionViewDelegate{
}

extension MainScreen:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return service.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.identifier, for:indexPath) as? ServicesCollectionViewCell
        cell?.setup(with: service[indexPath.row])
        //        cell?.desingMyCell()
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 1 {
            let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 2 {
            let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 3 {
            let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 4 {
            let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 5 {
            let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 6 {
            let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        if indexPath.item == 7 {
            let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
            navigationController?.pushViewController(viewController, animated: true)
        }
        if indexPath.item == 8 {
            let storyboard = UIStoryboard(name: "listOfProfessionals", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "listOfProfessionals")
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension MainScreen: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / 2.3, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    
}






