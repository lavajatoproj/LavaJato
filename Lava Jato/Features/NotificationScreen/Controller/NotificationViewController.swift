//
//  NotificationViewController.swift
//  Lava Jato
//
//  Created by Brendon Sambatti on 14/03/22.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroudView: UIImageView!
    
    @IBOutlet weak var segmentedControlSwitch: UISegmentedControl!
    
    private var viewModelNotificationScreen:ViewModelNotificationScreen = ViewModelNotificationScreen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.backgroudView.layer.cornerRadius = 15.0
        self.viewModelNotificationScreen.appendData()
        self.configSegmentControl()

    }
    
    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(NotificationTableViewCell.nib(), forCellReuseIdentifier: NotificationTableViewCell.identifier)
        self.tableView.layer.cornerRadius = 15.0
        self.tableView.backgroundColor = UIColor.clear
    }
    
    func configSegmentControl(){
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.ColorDefault]
        segmentedControlSwitch.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControlSwitch.setTitleTextAttributes(titleTextAttributes, for: .highlighted)
        
    }
    
    @IBAction func tappedSegmentControl(_ sender: UISegmentedControl) {
        self.tableView.reloadData()

    }
    
}

extension NotificationViewController:UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModelNotificationScreen.countCells(segment: self.segmentedControlSwitch)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as? NotificationTableViewCell
        switch segmentedControlSwitch.selectedSegmentIndex {
        case 0:
            cell?.data(profile: self.viewModelNotificationScreen.loadCellUser(indexPath: indexPath))
            cell?.xibView.layer.borderWidth = 0.0
        case 1:
            cell?.dataService(profileService: self.viewModelNotificationScreen.loadCellService(indexPath: indexPath))
            cell?.xibView.layer.borderWidth = 0.0
        default:
            break
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModelNotificationScreen.heightForRow
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletAction = UIContextualAction(style: .destructive, title: nil){action, view, boolAction in
            self.viewModelNotificationScreen.removeIndex(indexPath: indexPath)
            tableView.performBatchUpdates{
                tableView.deleteRows(at: [indexPath], with: .fade)
            } completion: { completed in
            }
        }
        deletAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deletAction])
    }
}
extension UISegmentedControl
{
    func defaultConfiguration(font: UIFont = UIFont.systemFont(ofSize: 12), color: UIColor = UIColor.white)
    {
        let defaultAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(defaultAttributes, for: .normal)
    }

    func selectedConfiguration(font: UIFont = UIFont.boldSystemFont(ofSize: 12), color: UIColor = UIColor.red)
    {
        let selectedAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
