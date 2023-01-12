//
//  UserProfileCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 11/01/2023.
//

import UIKit

class UserProfileCell: UICollectionViewCell {

    @IBOutlet weak var profileTitleLbl: UILabel!
    @IBOutlet weak var profileIgmView: UIImageView!
    
    var onTapped: (() -> Void)?
    
    func configure(with profile: PCProfile) {
        // validate default profile
        if profile.id == "" {
            profileTitleLbl.text = "-- Chọn loại hồ sơ --"
            profileIgmView.image = nil
        } else {
            profileTitleLbl.text = profile.title
            profileIgmView.image = UIImage(named: profile.imageURLString)
        }
     
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Colors.border.cgColor
        
        // tap event
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellTapped(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func cellTapped(sender: UICollectionViewCell) {
        onTapped?()
    }
}


extension UserProfileCell: NibLoadableView {}
