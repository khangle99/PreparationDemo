//
//  AvatarCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 12/01/2023.
//

import UIKit

class AvatarCell: UICollectionViewCell {

    @IBOutlet weak var removeBtn: UIImageView!
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var checkImgView: UIImageView!
    
    var onRemoveTapped: (()->Void)?
    
    func configure(with image: UIImage, isSelected: Bool, isUserImage: Bool) {
        avatarImgView.image = image
        removeBtn.isHidden = !isUserImage
        updateSelectState(isSelected: isSelected)
    }
    
    func updateSelectState(isSelected: Bool) {
        let uiColor = isSelected ? Colors.appPrimary : Colors.appPrimary.withAlphaComponent(0.3)
        avatarImgView.layer.borderColor = uiColor.cgColor
        avatarImgView.layer.borderWidth = isSelected ? 2 : 0.5
        checkImgView.isHidden = !isSelected
    }
    
    @objc func removeTapped(sender: UIImageView) {
        print("remove tapped")
        onRemoveTapped?()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // original bound tap area
        if let bodyView = super.hitTest(point, with: event) {
            return bodyView
        }
        // enable full close btn tap area
        if !self.clipsToBounds || !self.isHidden || self.alpha != 0 {
            let point = removeBtn.convert(point, from: self)
            if let view = removeBtn.hitTest(point, with: event), view === removeBtn {
                return removeBtn
            }
        }
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImgView.layer.cornerRadius = 8
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeTapped(sender:)))
        removeBtn.addGestureRecognizer(tap)
    }
}

extension AvatarCell: NibLoadableView {}
