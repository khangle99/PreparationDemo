//
//  ParentalControlTabControllerViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 05/01/2023.
//

import UIKit

class ParentalControlTabController: UITabBarController {
    
    static let topToolBarSpacing: CGFloat = 32
    static let botToolBarSpacing: CGFloat = 15
    static let toolBarHeight: CGFloat = 32
    
    // MARK: Properties
    private let customTabBar = HiFPTTabbar()
    private lazy var notiButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 22),
            button.heightAnchor.constraint(equalToConstant: 22)
        ])
        button.setImage(UIImage(named: "noti"), for: .normal)
        button.addTarget(self, action: #selector(notiTapped(_:)), for: .touchUpInside)
        let barBtn = UIBarButtonItem(customView: button)
        return barBtn
    }()
    
    private lazy var moreButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.tintColor = .white
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 22),
            button.heightAnchor.constraint(equalToConstant: 22)
        ])
        button.setImage(UIImage(named: "more"), for: .normal)
        button.addTarget(self, action: #selector(moreTapped(_:)), for: .touchUpInside)
        
        let barBtn = UIBarButtonItem(customView: button)
        return barBtn
    }()
    
    private lazy var settingButton: UIButton = {
        let settingBtn = UIButton(type: .custom)
        settingBtn.setImage(UIImage(named: "setting"), for: .normal)
        NSLayoutConstraint.activate([
            settingBtn.widthAnchor.constraint(equalToConstant: 20),
            settingBtn.heightAnchor.constraint(equalToConstant: 20)
        ])
        settingBtn.addTarget(self, action: #selector(settingTapped(_:)), for: .touchUpInside)
        return settingBtn
    }()
    
    var isShowNotiBadge: Bool = false {
        didSet {
            notiRedDotBadge.isHidden = !isShowNotiBadge
        }
    }
    
    private lazy var notiRedDotBadge: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(ovalIn: .init(origin: .zero, size: .init(width: 7, height: 7))).cgPath
        layer.fillColor = UIColor.red.cgColor
        notiButton.customView?.layer.addSublayer(layer)
        return layer
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Parental Control"
        setupNavigationBar()
        setupTabbar()
        
        changeVC(at: 0)
        // show badge
        isShowNotiBadge = true
        
        // way 1
//        viewControllers?.forEach {$0.additionalSafeAreaInsets = .init(top: 0, left: 0, bottom: 50, right: 0)}
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let notiFrame = notiButton.customView?.frame {
            notiRedDotBadge.frame.origin = .init(x: notiFrame.maxX - 7, y: notiFrame.minX)
        }
    }
    
    private func setupNavigationBar() {
        // set back image
        let backImg = UIImage(named: "ic_back_white")?.resizeImage(targetSize: .init(width: 21, height: 18))?.withAlignmentRectInsets(.init(top: 0, left: -10, bottom: 0, right: 0)).withRenderingMode(.alwaysOriginal)
        
        // navigationBar
        if let navBar = navigationController?.navigationBar {
            configureNavBarStyle(navbar: navBar, backroundColor: nil, titleColor: .white, backImage: backImg)
        }
        
        // right menu
        navigationItem.rightBarButtonItems = [moreButton, notiButton]
    }
    
    func configureNavBarStyle(navbar: UINavigationBar, backroundColor: UIColor? = nil, titleColor: UIColor? = nil, backImage: UIImage? = nil) {
        if #available(iOS 13, *) {
            // transparance nav
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.shadowColor = .clear
            if let backroundColor = backroundColor {
                appearance.backgroundColor = backroundColor
            }
            if let titleColor = titleColor {
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
            
            if let backImg = backImage {
                appearance.setBackIndicatorImage(backImg, transitionMaskImage: backImg)
            }
            
            navbar.standardAppearance = appearance
            navbar.scrollEdgeAppearance = appearance
        } else {
            // transparance nav
            navbar.setBackgroundImage(UIImage(), for: .default)
            navbar.isTranslucent = true
            navbar.shadowImage = UIImage()
            // barTint
            if let backroundColor = backroundColor {
                navbar.barTintColor = backroundColor
            }
            // titleColor
            if let titleColor = titleColor {
                navbar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            }
            
            // backImage
            if let backImg = backImage {
                navbar.backIndicatorImage = backImg
                navbar.backIndicatorTransitionMaskImage = backImage
            }
        }
        
    }

    private func setupTabbar() {
        //tabBar.isHidden = true
        
        //background view for tabbar
        let background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        background.backgroundColor = .white
        view.addSubview(background)
        
        customTabBar.backgroundColor = .white
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.items = [.init(selectedIcon: UIImage(named: "userTab")!.withRenderingMode(.alwaysTemplate), name: "Người dùng"), .init(selectedIcon: UIImage(named: "deviceTab")!.withRenderingMode(.alwaysTemplate), name: "Thiết bị") ]
        
        view.addSubview(customTabBar)
        customTabBar.hasActionButton = true
        customTabBar.actionButton.backgroundColor = Colors.appPrimary
        customTabBar.heightConstraint.constant = 48
        customTabBar.widthConstraint.constant = 64
        customTabBar.actionButton.layer.cornerRadius = 24
        customTabBar.actionButton.setImage(UIImage(named: "plus")?.resizeImage(targetSize: .init(width: 19, height: 19)), for: .normal)
        
        customTabBar.didTapActionButton = { [weak self] in
            print("action tap")
            let testVC = BaseViewController()
            testVC.title = "Test"
 
            testVC.view.backgroundColor = .blue
            self?.navigationController?.pushViewController(testVC, animated: true)
        }
        
        customTabBar.didSelectTab = { [weak self] index in
            self?.changeVC(at: index)
        }
        
        // constraint background and tabbar
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.topAnchor.constraint(equalTo: customTabBar.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 83),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func moreTapped(_ sender: UIButton) {
        print("more")
    }
    
    @objc func notiTapped(_ sender: UIButton) {
        print("noti")
        isShowNotiBadge = false
    }
    
    @objc func settingTapped(_ sender: UIButton) {
        print("setting")
    }
    
    // update tab ui state
    private func changeVC(at index: Int) {
        self.selectedIndex = index
    }
}


class CustomHeightTabBar: UITabBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        var sizeThatFits = super.sizeThatFits(size)
        
        sizeThatFits.height = 83
        
        return sizeThatFits
    }
}
