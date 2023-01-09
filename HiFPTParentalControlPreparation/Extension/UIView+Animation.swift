//
//  UIView+Animation.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 09/01/2023.
//

import Foundation
import UIKit

extension UIView {
    func tapAnimate() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .init(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            self.transform = .identity
        }

    }
}
