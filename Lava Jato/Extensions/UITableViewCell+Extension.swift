//
//  UITableViewCell+Extension.swift
//  Lava Jato
//
//  Created by Caio on 02/06/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    var tableView: UITableView? {
        return next(UITableView.self)
    }

    var indexPath: IndexPath? {
        return tableView?.indexPathForRow(at: self.center)
    }
}
