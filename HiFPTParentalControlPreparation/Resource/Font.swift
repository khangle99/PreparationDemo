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
}
