//
//  DeviceViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 05/01/2023.
//

import UIKit

class DeviceViewController: UIViewController {

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
        self.tabBarItem = UITabBarItem(title: "Thiết bị", image: UIImage(named: "deviceTab")?.resizeImage(targetSize: .init(width: 23, height: 23)), tag: 1)
    }

}
