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
    
    private var viewModelNotificationScreen:ViewModelNotificationScreen = ViewModelNotificationScreen()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.backgroudView.layer.cornerRadius = 15.0
        self.viewModelNotificationScreen.appendData()
    }
    
    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(NotificationTableViewCell.nib(), forCellReuseIdentifier: NotificationTableViewCell.identifier)
        self.tableView.layer.cornerRadius = 15.0
        self.tableView.backgroundColor = UIColor.clear
    }
}
extension NotificationViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModelNotificationScreen.countElementsArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath) as? NotificationTableViewCell
        cell?.dados(profile: self.viewModelNotificationScreen.loadCellUser(indexPath: indexPath))
        cell?.xibView.layer.borderWidth = 0.0
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
