//
//  UIResponder+Extension.swift
//  Lava Jato
//
//  Created by Caio on 02/06/22.
//

import Foundation
import UIKit

extension UIResponder {
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        self.next as? T ?? self.next?.next(type)
    }
}
