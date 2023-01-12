//
//  DeviceCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 09/01/2023.
//

import UIKit

class DeviceCell: UITableViewCell {

    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var deviceImgView: UIImageView!
    
    @IBOutlet weak var deviceNameLbl: UILabel!
    
    @IBOutlet weak var assignBtn: UIView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var assigneeLbl: UILabel!
    @IBOutlet weak var macAddLbl: UILabel!
    
    var onAssignTapped: ((_ device: PCDevice) -> Void)?
    
    private var device: PCDevice?
    
    private lazy var onlineStatusLayer: CAShapeLayer = {
        let c = CAShapeLayer()
        c.path = UIBezierPath(ovalIn: .init(origin: .zero, size: .init(width: 10, height: 10))).cgPath
        c.strokeColor = UIColor.white.cgColor
        c.fillColor = UIColor.red.cgColor
        horizontalStackView.layer.addSublayer(c)
        return c
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        assignBtn.layer.cornerRadius = 4
        // tap gesture
        
        let assignTapGes = UITapGestureRecognizer(target: self, action: #selector(assignTapped(sender:)))
        assignBtn.addGestureRecognizer(assignTapGes)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIfNeeded()
        let imgFrame = deviceImgView.frame
        
        onlineStatusLayer.frame = .init(origin: .init(x: imgFrame.maxX - 10, y: imgFrame.maxY - 10), size: .init(width: 10, height: 10))
        
    }
    
    func configure(device: PCDevice) {
        self.device = device
        deviceNameLbl.text = device.deviceName
        macAddLbl.text = device.macAddress
        deviceImgView.image = UIImage(named: device.imageURLStr) // temporary
        
        onlineStatusLayer.fillColor = device.assigneeId != nil ? Colors.onlineGreen.cgColor : Colors.disableButton.cgColor
        
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
