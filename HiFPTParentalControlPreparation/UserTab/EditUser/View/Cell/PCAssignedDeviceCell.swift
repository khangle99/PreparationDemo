//
//  PCAssignedDeviceCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 11/01/2023.
//

import UIKit

class PCAssignedDeviceCell: UICollectionViewCell {
    
    @IBOutlet weak var deviceNameLbl: UILabel!
    @IBOutlet weak var deviceImgView: UIImageView!
    private var device: PCDevice?
    
    var onRemoveTapped: ((_ device: PCDevice) -> Void)?
    
    func configure(with device: PCDevice) {
        self.device = device
        deviceNameLbl.text = device.deviceName
        deviceImgView.image = UIImage(named: device.imageURLStr)
    }
    
    @IBAction func removeTapped(_ sender: Any) {
        if let device = self.device {
            onRemoveTapped?(device)
        }
     
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Colors.border.cgColor
    }
}


extension PCAssignedDeviceCell: NibLoadableView {}
