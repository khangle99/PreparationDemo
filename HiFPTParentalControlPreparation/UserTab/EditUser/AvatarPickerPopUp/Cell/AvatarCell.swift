//
//  AvatarCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 12/01/2023.
//

import UIKit

class AvatarCell: UICollectionViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    
    func configure(with image: UIImage, isSelected: Bool) {
        avatarImgView.image = image
        updateSelectState(isSelected: isSelected)
    }
    
    func updateSelectState(isSelected: Bool) {
        let uiColor = isSelected ? Colors.appPrimary : Colors.appPrimary.withAlphaComponent(0.3)
        layer.borderColor = uiColor.cgColor
        layer.borderWidth = isSelected ? 2 : 0.5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
    }
}

extension AvatarCell: NibLoadableView {}
