//
//  ParentalControlTabControllerViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 05/01/2023.
//

import UIKit
import SwiftUI

class ParentalControlTabController: UITabBarController {
    
    private let customTabBar = HiFPTTabbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Parental Control"
        
        setupNavigationBar()
        setupTabbar()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tabBar.frame.size.height = 83
//        tabBar.frame.origin.y = view.frame.height - 83
//    }
//
    private func setupNavigationBar() {
        
        let backImg = UIImage(named: "back")?.resizeImage(targetSize: .init(width: 21, height: 18))?.withAlignmentRectInsets(.init(top: 0, left: -10, bottom: 0, right: 0))
        
        navigationController?.navigationBar.update(backroundColor: nil, titleColor: .black, backImage: backImg, backTitle: " ")

        self.navigationController?.navigationBar.topItem?.title = " "
    }
    
    private func setupTabbar() {
        tabBar.isHidden = true
        
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.items = [.init(selectedIcon: UIImage(named: "userTab")!.withRenderingMode(.alwaysTemplate), name: "Người dùng"), .init(selectedIcon: UIImage(named: "deviceTab")!.withRenderingMode(.alwaysTemplate), name: "Thiết bị") ]
        
        view.addSubview(customTabBar)
        customTabBar.hasActionButton = true
        customTabBar.actionButton.backgroundColor = UIColor(rgb: 0x4564ED)
        customTabBar.heightConstraint.constant = 48
        customTabBar.widthConstraint.constant = 64
        customTabBar.actionButton.layer.cornerRadius = 24
        customTabBar.didTapActionButton = { [weak self] in
            
        }
        
        customTabBar.didSelectTab = { [weak self] index in
            self?.selectedIndex = index
            
        }
        
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 83),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private lazy var stackTabbar: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.layoutMargins = .init(top: 17, left: 0, bottom: 17, right: 0)
        
        // user tab
        stack.addArrangedSubview(createTabItem(title: "Người dùng", image: UIImage(named: "userTab")))
        // plus
        let plusBtn = UIButton(type: .custom)
        plusBtn.setImage(UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusBtn.layer.cornerRadius = 28
        plusBtn.clipsToBounds = true
        plusBtn.backgroundColor = UIColor.init(rgb: 0x4564ED)
        stack.addArrangedSubview(plusBtn)
        NSLayoutConstraint.activate([
            plusBtn.widthAnchor.constraint(equalToConstant: 64),
            plusBtn.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // device tab
        stack.addArrangedSubview(createTabItem(title: "Thiết bị", image: UIImage(named: "deviceTab")))
        
        return stack
    }()

    private func createTabItem(title: String, image: UIImage? = nil) -> UIStackView {
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 8.5
        stack.axis = .vertical
        
        let tabImgView = UIImageView(image: image)
        tabImgView.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(tabImgView)
        NSLayoutConstraint.activate([
            tabImgView.widthAnchor.constraint(equalToConstant: 23),
            tabImgView.heightAnchor.constraint(equalToConstant: 23)
        ])
        
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = title
        //label.textColor = .black
        stack.addArrangedSubview(label)
        
        
        return stack
    }
  

}
