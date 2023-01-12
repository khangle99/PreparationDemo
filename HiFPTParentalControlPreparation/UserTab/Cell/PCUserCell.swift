//
//  PCUserCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 06/01/2023.
//

import UIKit

class PCUserCell: UITableViewCell {

    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var deviceCountLbl: UILabel!
    
    @IBOutlet weak var connectionButton: UIView!
    @IBOutlet weak var deleteUserButton: UIView!
    
    var onConnectTapped: ((_ user: PCUser) -> Void)?
    var onDeleteUserTapped: ((_ user: PCUser) -> Void)?
    var onCellTapped: ((_ user: PCUser) -> Void)?
    
    @IBOutlet weak var connectionImg: UIImageView!
    @IBOutlet weak var connectionLabel: UILabel!
    
    private var user: PCUser? = nil
    
    func configure(user: PCUser) {
        self.user = user
        avatarView.avatarImage = UIImage(named: user.imgURLString)
        nameLbl.text = user.userName
        categoryLbl.text = "Phân loại: \(user.profile.title)"
        deviceCountLbl.text = "\(user.deviceCount) thiết bị"
        
        let tintColor = user.isConnecting ? Colors.appPrimary : Colors.orange
        connectionLabel.textColor = tintColor
        connectionImg.tintColor = tintColor
        connectionImg.image = user.isConnecting ? UIImage(named: "pause") : UIImage(named: "continue")
        avatarView.statusColor = user.isConnecting ? Colors.onlineGreen : Colors.disableButton
        connectionLabel.text = user.isConnecting ? "Ngưng" : "Tiếp tục"
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.imageCornerRadius = avatarView.frame.height / 2
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
