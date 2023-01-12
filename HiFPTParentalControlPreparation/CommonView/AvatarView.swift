//
//  AvatarView.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 10/01/2023.
//

import UIKit

@IBDesignable
class AvatarView: UIView {
    
    lazy var avatarImageView: UIImageView =  {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var statusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = statusColor
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    @IBInspectable
    var avatarImage: UIImage? = nil {
        didSet {
            avatarImageView.image = avatarImage
        }
    }
    
    @IBInspectable
    var statusColor: UIColor = .green {
        didSet {
            statusView.backgroundColor = statusColor
        }
    }
    
    @IBInspectable
    var statusCircleWidthRatio: CGFloat = 0.25 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    var imageCornerRadius: CGFloat = 5 {
        didSet {
            avatarImageView.layer.cornerRadius = imageCornerRadius
            //            imageCornerMask.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: imageCornerRadius).cgPath
        }
    }
    
    @IBInspectable
    var statusIconDegree: CGFloat = 315 {
        didSet {
            let (horizontal, vertical) = calculatePosition(angle: statusIconDegree)
            statusView.center = CGPoint(x: bounds.width * horizontal, y: bounds.height * vertical)
        }
    }
    
    //    private lazy var imageCornerMask: CAShapeLayer = {
    //        let mask = CAShapeLayer()
    //        avatarImageView.layer.mask = mask
    //        return mask
    //    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        backgroundColor = .clear
        addSubview(avatarImageView)
        addSubview(statusView)
        
        // constraint avatarImgView
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    ///  Horizontal: 0.0 -> 1.0 (left edge -> right edge). Vertical: 0.0 -> 1.0 (top edge -> bottom edge)
    /// - Parameter angle: degree angle (from right, counter clock around circle)
    /// - Returns: Position tuple
    private func calculatePosition(angle: CGFloat) -> (CGFloat, CGFloat) {
        let radian = angle * .pi / 180
        let horizontal = (1 + cos(radian)) / 2
        let vertical = (1 - sin(radian)) / 2
        return (horizontal, vertical)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutStatusView()
        
//        imageCornerMask.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: bounds.height/2).cgPath
    }
    
    private func layoutStatusView() {
        
        /* statusView layout logic:
         position: center it to avatar image circle border
         size: calculate base on statusCircleWidthRatio, which relative on avatarImgView width
         */
        
        let (horizontal, vertical) = calculatePosition(angle: statusIconDegree)
        statusView.center = CGPoint(x: bounds.width * horizontal, y: bounds.height * vertical)
        let size = statusCircleWidthRatio * bounds.size.width
        statusView.bounds.size = CGSize(width: size, height: size)
        statusView.layer.cornerRadius = statusView.frame.height / 2
    }
}
