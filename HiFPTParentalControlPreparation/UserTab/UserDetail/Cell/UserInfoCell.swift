//
//  UserInfoCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 13/01/2023.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileTitleLbl: UILabel!
    
    func configure(user: PCUser) {
        avatarView.avatarImage = UIImage(named: user.imgURLString)
        userNameLbl.text = user.userName
        profileImgView.image = UIImage(named: user.profile.imageURLString)
        profileTitleLbl.text = user.profile.title
        avatarView.statusColor = user.isConnecting ? Colors.onlineGreen : Colors.disableButton
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.imageCornerRadius = avatarView.frame.height / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension UserInfoCell: NibLoadableView {}
