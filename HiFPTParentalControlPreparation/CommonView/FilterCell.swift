//
//  FilterCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 06/01/2023.
//

import UIKit

class FilterCell: UICollectionViewCell {

    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(filterData: FilterData, isSelect: Bool) {
        if isSelect {
            imgView.tintColor = Colors.appPrimary
            contentView.backgroundColor = .white
            stackContainer.backgroundColor = .white
            titleLabel.textColor = Colors.appPrimary
        } else {
            imgView.tintColor = .white
            contentView.backgroundColor = Colors.blue
            stackContainer.backgroundColor = Colors.blue
            titleLabel.textColor = .white
        }
        titleLabel.text = filterData.title
        if filterData.imgUrl != "" {
            imgView.image = UIImage(named: filterData.imgUrl)?.withRenderingMode(.alwaysTemplate) // temporary use named init, swap to url later
        } else {
            imgView.isHidden = true
        }
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
    }
}

extension FilterCell: NibLoadableView {}

struct FilterData {
    let title: String
    let imgUrl: String
}
