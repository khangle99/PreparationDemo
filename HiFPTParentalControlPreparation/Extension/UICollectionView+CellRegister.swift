//
//  UICollectionView+Identifider.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 09/01/2023.
//

import Foundation
import UIKit

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(of type: T.Type) where T: NibLoadableView {
        let bundle = Bundle(for: T.self)
           let nib = UINib(nibName: T.nibName, bundle: bundle)
           
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
       }
    
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}


