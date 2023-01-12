//
//  PCUserCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 06/01/2023.
//

import UIKit

class PCUserCell: UITableViewCell {

    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var deviceCountLbl: UILabel!
    
    @IBOutlet weak var connectionButton: UIView!
    @IBOutlet weak var deleteUserButton: UIView!
    
    private lazy var onlineStatusLayer: CAShapeLayer = {
        let c = CAShapeLayer()
        c.path = UIBezierPath(ovalIn: .init(origin: .zero, size: .init(width: 10, height: 10))).cgPath
        c.strokeColor = UIColor.white.cgColor
        c.fillColor = UIColor.red.cgColor
        layer.addSublayer(c)
        return c
    }()
    
    var onConnectTapped: ((_ user: PCUser) -> Void)?
    var onDeleteUserTapped: ((_ user: PCUser) -> Void)?
    var onCellTapped: ((_ user: PCUser) -> Void)?
    
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var connectionLabel: UILabel!
    
    private var user: PCUser? = nil
    
    func configure(user: PCUser) {
        self.user = user
        avatarImg.image = UIImage(named: user.imgURLString)
        nameLbl.text = user.userName
        categoryLbl.text = "Phân loại: \(user.profile.title)"
        deviceCountLbl.text = "\(user.deviceCount) thiết bị"
        
        let tintColor = user.isConnecting ? Colors.appPrimary : Colors.orange
        connectionLabel.textColor = tintColor
        connectionImg.tintColor = tintColor
        connectionImg.image = user.isConnecting ? UIImage(named: "pause") : UIImage(named: "continue")
        onlineStatusLayer.fillColor = user.isConnecting ? Colors.onlineGreen.cgColor : Colors.disableButton.cgColor
        connectionLabel.text = user.isConnecting ? "Ngưng" : "Tiếp tục"
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImg.backgroundColor = .red
        avatarImg.layer.cornerRadius = avatarImg.frame.height/2
        
        let avatarFrame = avatarImg.frame
        onlineStatusLayer.frame = .init(origin: .init(x: avatarFrame.maxX - 10, y: avatarFrame.maxY - 10), size: .init(width: 10, height: 10))
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // tap gesture
        let connectTapGes = UITapGestureRecognizer(target: self, action: #selector(connectionTapped(sender:)))
        connectionButton.addGestureRecognizer(connectTapGes)
        
        let deleteUserTapGes = UITapGestureRecognizer(target: self, action: #selector(deleteUserTapped(sender:)))
        deleteUserButton.addGestureRecognizer(deleteUserTapGes)
        
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(sender:)))
        contentView.addGestureRecognizer(cellTapGesture)
        
        connectionImg.image = connectionImg.image?.withRenderingMode(.alwaysTemplate)

    }
    
    @objc func cellTapped(sender: UIView) {
        if let user = user {
            onCellTapped?(user)
        }
    }
    
    @objc func connectionTapped(sender: UIView) {
        if let user = user {
            connectionButton.tapAnimate()
            onConnectTapped?(user)
        }
    }
    
    @objc func deleteUserTapped(sender: UIView) {
        if let user = user {
            deleteUserButton.tapAnimate()
            onDeleteUserTapped?(user)
        }
    }
}

extension PCUserCell: NibLoadableView {}