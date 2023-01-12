//
//  DeviceCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 09/01/2023.
//

import UIKit

class DeviceCell: UITableViewCell {

    @IBOutlet weak var horizontalStackView: UIStackView!
    
    @IBOutlet weak var deviceAvatarImgView: AvatarView!
    @IBOutlet weak var deviceNameLbl: UILabel!
    
    @IBOutlet weak var assignBtn: UIView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var assigneeLbl: UILabel!
    @IBOutlet weak var macAddLbl: UILabel!
    
    var onAssignTapped: ((_ device: PCDevice) -> Void)?
    
    private var device: PCDevice?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        assignBtn.layer.cornerRadius = 4
        // tap gesture
        
        let assignTapGes = UITapGestureRecognizer(target: self, action: #selector(assignTapped(sender:)))
        assignBtn.addGestureRecognizer(assignTapGes)
        
        deviceAvatarImgView.avatarImageView.contentMode = .scaleAspectFit
        deviceAvatarImgView.statusCircleWidthRatio = 0.4
    }
    
    func configure(device: PCDevice) {
        self.device = device
        deviceNameLbl.text = device.deviceName
        macAddLbl.text = device.macAddress
        deviceAvatarImgView.avatarImage = UIImage(named: device.imageURLStr) // temporary
        
        deviceAvatarImgView.statusColor = device.assigneeId != nil ? Colors.onlineGreen : Colors.disableButton
        
        if device.assigneeId != nil {
            assigneeLbl.isHidden = false
            assignBtn.isHidden = true
            let str = NSMutableAttributedString()
            str.append(NSMutableAttributedString(string: "Gắn cho: ", attributes: [
                .foregroundColor : Colors.textGray,
                .font : Font.mediumInter(of: 12)
            ]))
            
            str.append(NSMutableAttributedString(string: "Mẹ", attributes: [
                .foregroundColor : Colors.orange,
                .font : Font.mediumInter(of: 12),
                .underlineStyle : NSUnderlineStyle.single.rawValue
            ]))
            
            assigneeLbl.attributedText = str
        } else {
            assigneeLbl.isHidden = true
            assignBtn.isHidden = false
        }
    }
    
    @objc func assignTapped(sender: UIView) {
        assignBtn.tapAnimate()
        if let device = device {
            onAssignTapped?(device)
        }
    }
    
    
}
extension DeviceCell: NibLoadableView {}
