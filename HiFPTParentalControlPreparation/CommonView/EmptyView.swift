//
//  EmptyView.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 13/01/2023.
//

import UIKit

class EmptyView: UIView {

    lazy var emptyLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = Font.mediumInter(of: 14)
        lbl.textColor = Colors.black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var emptyImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "emptyLogo")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(emptyImgView)
        addSubview(emptyLbl)
        
        // constraint
        NSLayoutConstraint.activate([
            emptyImgView.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            emptyImgView.widthAnchor.constraint(equalToConstant: 156),
            emptyImgView.heightAnchor.constraint(equalToConstant: 194),
            emptyImgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLbl.topAnchor.constraint(equalTo: emptyImgView.bottomAnchor, constant: 8),
            emptyLbl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    class func initWith(description string: String) -> EmptyView {
        let v = EmptyView()
        v.emptyLbl.text = string
        return v
    }

}
