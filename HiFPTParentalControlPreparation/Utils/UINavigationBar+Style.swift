//
//  UINavigationBar+Style.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 05/01/2023.
//

import Foundation
import UIKit

extension UINavigationBar {
    func update(backroundColor: UIColor? = nil, titleColor: UIColor? = nil, backImage: UIImage? = nil, backTitle: String? = nil) {
    if #available(iOS 15, *) {
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
      barStyle = .blackTranslucent
      if let backroundColor = backroundColor {
        barTintColor = backroundColor
      }
      if let titleColor = titleColor {
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
      }
    }
  }
}
