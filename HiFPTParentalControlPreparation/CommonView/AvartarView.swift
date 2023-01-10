//
//  AvartarView.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 10/01/2023.
//

import UIKit

@IBDesignable
class AvartarView: UIView {
    
    private lazy var avartarImageView: UIImageView =  {
        let imgView = UIImageView()
        //imgView.contentMode = .scaleAspectFit
        imgView.backgroundColor = .red
        imgView.image = UIImage(named: "quanly")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private lazy var statusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = statusColor
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    var avartarImage: UIImage? = nil {
        didSet {
            avartarImageView.image = avartarImage
        }
    }
    
    var statusColor: UIColor = .green {
        didSet {
            statusView.backgroundColor = statusColor
        }
    }
    
    var statusCircleSize: CGSize = .init(width: 10, height: 10) {
        didSet {
            statusView.frame.size = statusCircleSize
        }
    }
    
    var statusCircleInset: UIEdgeInsets = .zero {
        didSet {
            //layoutIfNeeded()
        }
    }
    
    @IBInspectable
    var imageCornerRadius: CGFloat = 5 {
        didSet {
            avartarImageView.layer.cornerRadius = imageCornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        addSubview(avartarImageView)
        addSubview(statusView)
        
        // constraint
        NSLayoutConstraint.activate([
            avartarImageView.topAnchor.constraint(equalTo: topAnchor),
            avartarImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            avartarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avartarImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
//
//        NSLayoutConstraint.activate([
//            statusView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            statusView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            statusView.widthAnchor.constraint(equalToConstant: statusCircleSize.width),
//            statusView.heightAnchor.constraint(equalToConstant: statusCircleSize.height)
//        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // calculate position status: right bottom
        let size = statusCircleSize
        statusView.frame = .init(origin: .init(x: bounds.maxX - size.width, y: bounds.maxY - size.height), size: size)
       
    }

}
