//
//  AvartarView.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 10/01/2023.
//

import UIKit

class AvartarView: UIImageView {
    
    private lazy var onlineStatusCircle: CAShapeLayer = {
        let c = CAShapeLayer()
        c.path = UIBezierPath(ovalIn: .init(origin: .zero, size: .init(width: 10, height: 10))).cgPath
        c.strokeColor = UIColor.white.cgColor
        c.fillColor = UIColor.red.cgColor
        layer.addSublayer(c)
        return c
    }()
    
    
    var statusColor: UIColor = .green {
        didSet {
            onlineStatusCircle.fillColor = statusColor.cgColor
        }
    }
    
    var statusCircleSize: CGSize = .init(width: 10, height: 10) {
        didSet {
            onlineStatusCircle.path = UIBezierPath(ovalIn: .init(origin: .zero, size: statusCircleSize)).cgPath
        }
    }
    
    var statusCircleInset: UIEdgeInsets = .zero {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var imageCornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = imageCornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initLayer()
    }
    
    private func initLayer() {
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // calculate position status: right bottom
        let size = statusCircleSize
        onlineStatusCircle.frame = .init(origin: .init(x: frame.maxX - size.width, y: frame.maxY - size.height), size: size)
    }
    
    

}
