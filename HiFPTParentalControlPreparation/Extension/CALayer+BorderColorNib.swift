//
//  CALayer+BorderColorNib.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 11/01/2023.
//

import Foundation
import UIKit

extension CALayer {
    @objc var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
    
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}
