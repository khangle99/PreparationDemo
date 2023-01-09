//
//  UITableView+CellRegister.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 09/01/2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNib<T: UITableViewCell>(of type: T.Type) where T: NibLoadableView {
        let bundle = Bundle(for: T.self)
           let nib = UINib(nibName: T.nibName, bundle: bundle)
           
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
       }
    
    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
