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
    @IBOutlet weak var deviceImageView: UIImageView!
    
    func configure(device: PCDevice) {
        deviceMacAddLbl.text = device.macAddress
        deviceNameLbl.text = device.deviceName
        deviceImageView.image = UIImage(named: device.imageURLStr)
    }
}

extension UserDeviceCell: NibLoadableView {}
