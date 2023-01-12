//
//  HeaderBarViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 13/01/2023.
//

import Foundation
import UIKit

class CustomHeightViewController: UIViewController {
    
    var headerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Colors.appPrimary
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImg = UIImage(named: "ic_back_white")?.resizeImage(targetSize: .init(width: 21, height: 18))?.withAlignmentRectInsets(.init(top: 0, left: -10, bottom: 0, right: 0)).withRenderingMode(.alwaysOriginal)
        
        // navigationBar
        if let navBar = navigationController?.navigationBar {
            configureNavBarStyle(navbar: navBar, backroundColor: nil, titleColor: .white, backImage: backImg)
        }
        
        // add header
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateAdditionalSafeAreaInset()
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
    
    private func updateAdditionalSafeAreaInset() {
        // update top additional
        let inset = UIEdgeInsets(top: calculateAdditionalTopInset(), left: 0, bottom: 0, right: 0)
        additionalSafeAreaInsets = inset
    }
    
    private func calculateAdditionalTopInset() -> CGFloat {
        // get top inset
        var originTopInset: CGFloat = 0

        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            originTopInset = window?.safeAreaInsets.top ?? 0
        } else {
            let window = UIApplication.shared.keyWindow
            originTopInset = window?.safeAreaInsets.top ?? 0
        }
//        // 23:4 ratio
//        let vcWidth = view.bounds.width
//
//        let navHeight = navigationController?.navigationBar.frame.height ?? 0
//        let safeAreaWithouNavBar = originTopInset - navHeight
//
//        let headerTargetHeight: CGFloat = safeAreaWithouNavBar + vcWidth*4/23.0
//         rule: originInset + additionInset = headerTargetHeight
//        return headerTargetHeight - originTopInset
        let targetHeight = view.bounds.width*4/23.0
        return targetHeight - originTopInset
    }
}
