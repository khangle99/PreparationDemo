//
//  UploadSelectCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 12/01/2023.
//

import UIKit

class UploadSelectCell: UICollectionViewCell {

    
    private lazy var dashBorderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = nil
        layer.strokeColor = Colors.lineBlue.cgColor
        layer.lineDashPattern = [6, 2]
        return layer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dashBorderLayer.path = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: 8).cgPath
        dashBorderLayer.frame = self.bounds
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.addSublayer(dashBorderLayer)
    }
    

}

extension UploadSelectCell: NibLoadableView {}
