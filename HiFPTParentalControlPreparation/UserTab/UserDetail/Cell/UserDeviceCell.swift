//
//  UserDeviceCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 10/01/2023.
//

import UIKit

class UserDeviceCell: UITableViewCell {
    
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var deviceMacAddLbl: UILabel!
    @IBOutlet weak var deviceNameLbl: UILabel!
    @IBOutlet weak var avatarView: AvatarView!
    
    func configure(device: PCDevice) {
        deviceMacAddLbl.text = device.macAddress
        deviceNameLbl.text = device.deviceName
        avatarView.avatarImage = UIImage(named: device.imageURLStr)
        avatarView.statusColor = device.assigneeId != nil ? Colors.onlineGreen : Colors.red
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView.avatarImageView.contentMode = .scaleAspectFit
        avatarView.statusCircleWidthRatio = 0.25
    }
}

extension UserDeviceCell: NibLoadableView {}
