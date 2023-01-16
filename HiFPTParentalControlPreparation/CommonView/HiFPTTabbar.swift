//
//  HiFPTTabbar.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 05/01/2023.
//

import Foundation
import UIKit

class HiFPTTabbar: UIStackView {
    
    var selectedTint: UIColor = Colors.appPrimary {
        didSet {
            itemViews.forEach { $0.selectedTint = selectedTint}
        }
    }
    var unSelectedTint: UIColor = Colors.disableButton {
        didSet {
            itemViews.forEach { $0.unselectedTint = unSelectedTint}
        }
    }
    
    var selectIndex: Int = 0
    
    var items: [TabItem] = [] {
        didSet {
            itemViews = items.enumerated().map({ (index, element) in
                return TabItemView(with: element, index: index)
            })
            
            itemViews.forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.clipsToBounds = true
                self.addArrangedSubview($0)
                $0.onTapped = { [weak self] index in
                    self?.selectItem(index: index)
                }
            }
            selectItem(index: 0)
        }
    }
    private var itemViews: [TabItemView] = []
    var didSelectTab: ((Int) -> Void)?
    var didTapActionButton: (()->Void)?
    
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    init() {
        super.init(frame: .zero)
        
        setNeedsLayout()
        //layoutIfNeeded()
        setupProperties()
        
        
        // action button
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        widthConstraint = actionButton.widthAnchor.constraint(equalToConstant: 30)
        heightConstraint = actionButton.heightAnchor.constraint(equalToConstant: 30)
        actionButton.layer.cornerRadius = 26 // fix later
        widthConstraint.isActive = true
        heightConstraint.isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bringSubviewToFront(actionButton)
    }
    
    private func selectItem(index: Int) {
        // animate
        itemViews.forEach { $0.isSelected = $0.index == index }
        didSelectTab?(index)
    }
    
    private func setupProperties() {
        distribution = .fillEqually
        alignment = .center
        axis = .horizontal
        backgroundColor = .white
    }
    
    lazy var actionButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(tapAction(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func tapAction(sender: UIButton) {
        didTapActionButton?()
    }
    
    // center action button
    var hasActionButton = false {
        didSet {
            actionButton.isHidden = !hasActionButton
        }
    }
    
}

// MARK: TabItemView
class TabItemView: UIView {
    let nameLabel = UILabel()
    let iconImageView = UIImageView()
    let containerView = UIView()
    var onTapped: ((Int) -> Void)? = nil
    let index: Int
    
    var isSelected = false {
        didSet {
            animateItems()
        }
    }
    
    var selectedTint: UIColor = .systemBlue
    var unselectedTint: UIColor = .gray
    
    private let item: TabItem
    
    init(with item: TabItem, index: Int) {
        self.item = item
        self.index = index
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupProperties()
        setupTapGesture()
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        onTapped?(index)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(iconImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 23),
            iconImageView.heightAnchor.constraint(equalToConstant: 23),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 16)
        ])

    }
    
    private func setupProperties() {
        nameLabel.textColor = isSelected ? Colors.appPrimary : Colors.disableButton
        nameLabel.text = item.name
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 12)
        
        iconImageView.image = isSelected ? item.selectedIcon : item.selectedIcon
    }
    
    private func setupTapGesture() {
        let tapReg = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        self.addGestureRecognizer(tapReg)
    }
    
    private func animateItems() {
        UIView.transition(with: iconImageView,
                          duration: 0.1,
                          options: .transitionCrossDissolve) { [unowned self] in
            self.iconImageView.tintColor = self.isSelected ? selectedTint : unselectedTint
            nameLabel.textColor = self.isSelected ? selectedTint : unselectedTint
            
        }
    }
}

struct TabItem {
    var icon: UIImage?
    var selectedIcon: UIImage
    var name: String
}
