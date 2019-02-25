//
// DequeueReusableTableView.swift 
// SwiftDemo 
// 
// Created by Plena on 2019/2/25. 
// Copyright © 2019 Linzy. All rights reserved.
// 


import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(with cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: type(of: cellClass))
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
