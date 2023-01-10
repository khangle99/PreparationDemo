//
//  PCUserDetailViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 10/01/2023.
//

import UIKit

class PCUserDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Chi tiết người dùng"
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "edit"), for: .normal)
        btn.addTarget(self, action: #selector(editTapped(sender:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 18),
            btn.heightAnchor.constraint(equalToConstant: 18)
        ])
        let barButton = UIBarButtonItem(customView: btn)
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func editTapped(sender: UIButton) {
        print("edit tapped")
    }

}
