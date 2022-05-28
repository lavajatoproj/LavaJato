//
//  MainScreen.swift
//  Lava Jato
//
//  Created by Thiago Valentim on 18/02/22.
//


import UIKit

class MainScreen: UIViewController {
    
    @IBOutlet weak var cvCollectionView: UICollectionView!
    
    private var newServiceViewModel:NewServiceViewModel = NewServiceViewModel()
    private var infos: Users?

    private var arrayNames2:[Professionals] = [
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Thiago", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: false, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Bruno", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: false, washPolishing: false, dryWash: false, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Olivia", userRate: 4.5, userServices: [.init(simpleWash: false, completWash: true, washPolishing: true, dryWash: true, steamWash: false, ecoWash: true, airPurification: false, sanitation: true)]),
        Professionals(userImage: UIImage(systemName:"person.circle") ?? UIImage(), userName: "Fred", userRate: 4.5, userServices: [.init(simpleWash: true, completWash: true, washPolishing: true, dryWash: true, steamWash: true, ecoWash: false, airPurification: false, sanitation: true)])

    ]

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
            for user in arrayNames2 {
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
//        viewController.self?.newServiceViewModel =
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
