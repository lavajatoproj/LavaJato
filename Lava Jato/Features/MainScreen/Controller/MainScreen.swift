//
//  MainScreen.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 18/02/22.
//


import UIKit

class MainScreen: UIViewController {
    
    @IBOutlet weak var cvCollectionView: UICollectionView!
    
//    private var newServiceViewModel:NewServiceViewModel = NewServiceViewModel()
    private var viewModel:MainViewModel = MainViewModel()
    private var infos: Users?

   
    var arrayNames2:[Professionals] = []
    var filterArray:[Professionals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingCV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.filterArray = []
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
extension MainScreen:UICollectionViewDelegate{}
extension MainScreen:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return service.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesCollectionViewCell.identifier, for:indexPath) as? ServicesCollectionViewCell
        cell?.setup(with: service[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item{
        case 0:
            var count:Int = 0
            for user in arrayNames2{
                let type = arrayNames2[count].userServices[0].simpleWash
                count = count + 1
                if type == true {
                    filterArray.append(user)
                }
            }
        case 1:
            var count:Int = 0
            for user in arrayNames2 {
                let type = arrayNames2[count].userServices[0].completWash
                count = count + 1
                if type == true {
                    filterArray.append(user)
                }
            }
        case 2:
            var count:Int = 0
            for user in arrayNames2 {
                let type = arrayNames2[count].userServices[0].washPolishing
                count = count + 1
                if type == true {
                    filterArray.append(user)
                }
            }
        case 3:
            var count:Int = 0
            for user in arrayNames2 {
                let type = arrayNames2[count].userServices[0].dryWash
                count = count + 1
                if type == true {
                    filterArray.append(user)
                }
            }
        case 4:
            var count:Int = 0
            for user in arrayNames2 {
                let type = arrayNames2[count].userServices[0].steamWash
                count = count + 1
                if type == true {
                    filterArray.append(user)
                }
            }
        case 5:
            var count:Int = 0
            for user in arrayNames2 {
                let type = arrayNames2[count].userServices[0].ecoWash
                count = count + 1
                if type == true {
                    filterArray.append(user)
                }
            }
        case 6:
            var count:Int = 0
            for user in arrayNames2 {
                let type = arrayNames2[count].userServices[0].airPurification
                count = count + 1
                if type == true {
                    filterArray.append(user)
                }
            }
        default:
            var count:Int = 0
            for user in arrayNames2 {
                let type = arrayNames2[count].userServices[0].sanitation
                count = count + 1
                if type == true {
                    filterArray.append(user)
                }
            }
        }
        
        let storyboard = UIStoryboard(name: "NewServiceStoryBoard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewServiceStoryBoard") as? NewServiceViewController
        viewController?.filterArray = filterArray
        navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
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
