//
//  BannedContentCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 10/01/2023.
//

import UIKit

class BannedContentCell: UITableViewCell {
    @IBOutlet weak var bannedIcon: UIImageView!
    
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var bannedLbl: UILabel!
    private var bannedContent: BannedContent?
    
    func configure(_ bannedContent: BannedContent) {
        self.bannedContent = bannedContent
        bannedIcon.image = UIImage(named: bannedContent.imgURL) // temporary
        bannedLbl.text = bannedContent.name
    }
}

extension BannedContentCell: NibLoadableView {}

struct BannedContent {
    let id: String
    let name: String
    let imgURL: String
}
