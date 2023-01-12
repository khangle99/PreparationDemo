//
//  HeaderView.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 11/01/2023.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLbl: UILabel!
    
    func configure(with title: String) {
        titleLbl.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension HeaderView: NibLoadableView {}
