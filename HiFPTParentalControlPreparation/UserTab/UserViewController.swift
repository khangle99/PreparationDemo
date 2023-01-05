//
//  UserViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 05/01/2023.
//

import UIKit

class UserViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabbarItem()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabbarItem()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTabbarItem() {
        //assign button to navigationbar
        self.tabBarItem = UITabBarItem(title: "Người dùng", image: UIImage(named: "userTab")?.resizeImage(targetSize: .init(width: 23, height: 23)), tag: 0)
    }

}
