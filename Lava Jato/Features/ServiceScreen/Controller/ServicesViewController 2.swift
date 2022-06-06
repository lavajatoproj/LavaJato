//
//  ServicesViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 14/03/22.
//

import UIKit

class ServicesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroudView: UIImageView!
    
    @IBOutlet weak var segmentedControlSwitch: UISegmentedControl!
    
    private var viewModelServices:ViewModelServices = ViewModelServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.viewModelServices.appendData()
        self.configSegmentControl()
    }
    
    func configTableView(){
        self.backgroudView.layer.cornerRadius = 15.0
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ServiceTableViewCell.nib(), forCellReuseIdentifier: ServiceTableViewCell.identifier)
        self.tableView.layer.cornerRadius = 15.0
        self.tableView.backgroundColor = UIColor.clear
    }
    
    func configSegmentControl(){
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControlSwitch.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControlSwitch.setTitleTextAttributes(titleTextAttributes, for: .highlighted)
    }
    @IBAction func tappedSegmentControl(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
}
extension ServicesViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModelServices.countCells(segment: self.segmentedControlSwitch)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.identifier, for: indexPath) as? ServiceTableViewCell
        switch segmentedControlSwitch.selectedSegmentIndex {
        case 0:
            cell?.data(profile: self.viewModelServices.loadCellUser(indexPath: indexPath))
        case 1:
            cell?.dataService(profileService: self.viewModelServices.loadCellService(indexPath: indexPath))
        default:
            break
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModelServices.heightForRow
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch segmentedControlSwitch.selectedSegmentIndex {
        case 0:
            let deletAction = UIContextualAction(style: .destructive, title: nil){action, view, boolAction in
                self.viewModelServices.removeIndexData(indexPath: indexPath)
                tableView.performBatchUpdates{
                    tableView.deleteRows(at: [indexPath], with: .fade)
                } completion: { completed in
                }
            }
            deletAction.image = UIImage(systemName: "trash")
            return UISwipeActionsConfiguration(actions: [deletAction])
        default:
            let deletAction = UIContextualAction(style: .destructive, title: nil){action, view, boolAction in
                self.viewModelServices.removeIndexService(indexPath: indexPath)
                tableView.performBatchUpdates{
                    tableView.deleteRows(at: [indexPath], with: .fade)
                } completion: { completed in
                }
            }
            deletAction.image = UIImage(systemName: "trash")
            return UISwipeActionsConfiguration(actions: [deletAction])
        }
    }
}
extension UISegmentedControl{
    func defaultConfiguration(font: UIFont = UIFont.systemFont(ofSize: 15), color: UIColor = UIColor.white){
        let defaultAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(defaultAttributes, for: .normal)
    }
    func selectedConfiguration(font: UIFont = UIFont.boldSystemFont(ofSize: 15), color: UIColor = UIColor.red){
        let selectedAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
