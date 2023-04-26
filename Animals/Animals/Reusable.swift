//
//  Reusable.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import UIKit

typealias ReusableTableViewCell = UITableViewCell & Reusable

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String { String(describing: self) }
}

extension UITableView {
    func register<T: ReusableTableViewCell>(_ cell: T.Type) {
        register(T.self, forCellReuseIdentifier: cell.identifier)
    }
    
    func reuse<T: ReusableTableViewCell>(for cell: T.Type, at indexPath: IndexPath) -> T {        let cell = dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath)
        return cell as! T
    }
}
