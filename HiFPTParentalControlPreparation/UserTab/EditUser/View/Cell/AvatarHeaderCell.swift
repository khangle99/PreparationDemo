//
//  AvatarCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 11/01/2023.
//

import UIKit

class AvatarHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImgView: UIImageView!
    var onAvatarTapped: (() -> Void)?
    
    func configure(with image: UIImage) {
        avatarImgView.image = image
    }
    
    func configure(with imageURL: String) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImgView.layer.cornerRadius = 48
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped(sender:)))
        avatarImgView.addGestureRecognizer(tap)
    }
    
    @objc func avatarTapped(sender: UITapGestureRecognizer) {
        onAvatarTapped?()
    }
}

extension AvatarHeaderCell: NibLoadableView {}
