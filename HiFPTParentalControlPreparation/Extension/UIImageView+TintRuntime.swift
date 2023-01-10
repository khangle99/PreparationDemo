//
//  UIImageView+TintRuntime.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 11/01/2023.
//

import Foundation
import UIKit

extension UIImageView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        tintColorDidChange()
    }
}
