//
//  Font.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 09/01/2023.
//

import Foundation
import UIKit

struct Font {
    static func mediumInter(of size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func semiBoldInter(of size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-SemiBold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func regularInter(of size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: size) ?? .systemFont(ofSize: size)
    }
}
