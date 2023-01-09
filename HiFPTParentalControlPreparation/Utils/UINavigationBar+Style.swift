//
//  UINavigationBar+Style.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 05/01/2023.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func update(backroundColor: UIColor? = nil, titleColor: UIColor? = nil, backImage: UIImage? = nil) {
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.shadowColor = .clear
            if let backroundColor = backroundColor {
                appearance.backgroundColor = backroundColor
            }
            if let titleColor = titleColor {
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
            
            if let backImg = backImage {
                appearance.setBackIndicatorImage(backImg, transitionMaskImage: backImg)
            }
            
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        } else {
            // transparance nav
            setBackgroundImage(UIImage(), for: .default)
            isTranslucent = true
            shadowImage = UIImage()
            // barTint
            if let backroundColor = backroundColor {
                barTintColor = backroundColor
            }
            // titleColor
            if let titleColor = titleColor {
                titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
            
            // backImage
            if let backImg = backImage {
                backIndicatorImage = backImg
                backIndicatorTransitionMaskImage = backImage
            }
        }
    }
}
