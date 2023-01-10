////
////  ButtonPrimary.swift
////  Hi FPT
////
////  Created by Jenny on 12/09/2021.
////
//
//import UIKit
//
//@IBDesignable
//class ButtonPrimary: UIButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        isEnabled = true
//    }
//
//    override var isEnabled: Bool{
//        didSet{
//            layer.cornerRadius = 8
//            if (isEnabled) {
//                setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
//                backgroundColor =  #colorLiteral(red: 0.1450980392, green: 0.3215686275, blue: 0.8784313725, alpha: 1)
//
//            } else {
//                setTitleColor(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1), for: .normal)
//                backgroundColor =  #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 0.45)
//            }
//        }
//    }
//}
//
//
//class ButtonSecondary: UIButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        isEnabled = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override var isEnabled: Bool{
//        didSet{
//            if (isEnabled) {
//                setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
//                backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                roundCorner(borderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), borderWidth: 1, cornerRadius: 8)
//            } else {
//                setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
//                backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                roundCorner(borderColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), borderWidth: 1, cornerRadius: 8)
//            }
//        }
//    }
//
//}
//
//// temp
//extension UIButton {
//    func roundCorner(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
//        self.layer.borderColor = borderColor.cgColor
//        self.layer.borderWidth = borderWidth
//        self.layer.cornerRadius = cornerRadius
//    }
//}
//
//
//class ButtonWithBorder: UIButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        isEnabled = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override var isEnabled: Bool{
//        didSet{
//            if (isEnabled) {
//                setTitleColor(#colorLiteral(red: 0.27, green: 0.394, blue: 0.929, alpha: 1), for: .normal)
//                backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                roundCorner(borderColor: #colorLiteral(red: 0.27, green: 0.394, blue: 0.929, alpha: 1), borderWidth: 1, cornerRadius: 8)
//            } else {
//                setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), for: .normal)
//                backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//                roundCorner(borderColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), borderWidth: 1, cornerRadius: 8)
//            }
//        }
//    }
//}
//
//
//class HiHeaderView: UIView {
//
//    lazy var btnBack = ButtonLeftBar()
//    lazy var btnRightBarOPtion = ButtonRightBarOption()
//    lazy var lblTitle = LableTitle()
//    lazy var btnHistory = ButtonHistory()
////    var btnBackCallback : (()->Void)?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupUI()
//
//    }
//    func setupUI(){
//
//        btnBack.translatesAutoresizingMaskIntoConstraints = false
//        btnBack.setImage(UIImage(named: "ic_back_white"), for: .normal)
//        btnRightBarOPtion.translatesAutoresizingMaskIntoConstraints = false
//        btnRightBarOPtion.setImage(UIImage(named: "ic_dots_white"), for: .normal)
//        lblTitle.translatesAutoresizingMaskIntoConstraints = false
//        lblTitle.minimumScaleFactor = 0.8
//        lblTitle.adjustsFontSizeToFitWidth = true
//        lblTitle.text = ""
//        btnHistory.translatesAutoresizingMaskIntoConstraints = false
//        btnHistory.setImage(UIImage(named: "ic_history_white"), for: .normal)
//        self.addSubview(btnBack)
//        self.addSubview(btnRightBarOPtion)
//        self.addSubview(btnHistory)
//        btnHistory.isHidden = true
//        self.addSubview(lblTitle)
//        NSLayoutConstraint.activate([
//            btnBack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
//            btnBack.widthAnchor.constraint(equalTo: btnBack.heightAnchor, multiplier: 1),
//            btnBack.topAnchor.constraint(equalTo: self.topAnchor),
//            btnBack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            btnBack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//
//            btnRightBarOPtion.widthAnchor.constraint(equalTo: btnBack.widthAnchor),
//            btnRightBarOPtion.heightAnchor.constraint(equalTo: btnBack.heightAnchor),
//            btnRightBarOPtion.centerYAnchor.constraint(equalTo: btnBack.centerYAnchor),
//            btnRightBarOPtion.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//
//            btnHistory.widthAnchor.constraint(equalTo: btnBack.widthAnchor, multiplier: 0.8),
//            btnHistory.heightAnchor.constraint(equalTo: btnBack.heightAnchor),
//            btnHistory.centerYAnchor.constraint(equalTo: btnBack.centerYAnchor),
//            btnHistory.trailingAnchor.constraint(equalTo: btnRightBarOPtion.leadingAnchor, constant: 4),
//
//            lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            lblTitle.trailingAnchor.constraint(equalTo: btnHistory.leadingAnchor),
//            lblTitle.centerYAnchor.constraint(equalTo: btnBack.centerYAnchor),
//
//
//        ])
//    }
//}
//
//class ButtonRightBarOption: UIButton {
//    var data : [DropViewModel]? = [DropViewModel(imv: "back-to-home-black", title: Localizable.shared.localizedString(key: "back_to_home"))]
//    var callback : (()-> Void)?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupUI()
//
//    }
//    func setupUI(){
//        self.setTitle("", for: .normal)
//        self.setImage(UIImage(named: "ic_dots_white"), for: .normal)
//        self.addTarget(self, action: #selector(setFunctionRightBarOption), for: .touchUpInside)
//    }
//    @objc func setFunctionRightBarOption(){
//        if callback != nil{
//            callback?()
//        }else{
//            guard let data = data else {
//                return
//            }
//            DropDownManager.shared.showDropView(sender: self, data: data, onSelect: { [weak self] number in
//                switch number {
//                default :
//                    if let navigationController = self!.window?.rootViewController as? UINavigationController {
//                        navigationController.popToRootViewController(animated: true)
//                    }
//                }
//            })
//        }
//    }
//}
//class ButtonLeftBar: UIButton {
//    var callback : (()-> Void)?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupUI()
//
//    }
//    func setupUI(){
//        self.setTitle("", for: .normal)
//        self.setImage(UIImage(named: "ic_back_white"), for: .normal)
//        self.addTarget(self, action: #selector(setFunctionLeftBar), for: .touchUpInside)
//    }
//   @objc func setFunctionLeftBar(){
//       if callback == nil {
//           if let navigationController = self.window?.rootViewController as? UINavigationController {
//                   navigationController.popViewController(animated: true)
//           }
//       }else{
//           callback?()
//       }
//    }
//
//
//}
//class ButtonHistory: UIButton {
//    var callback : (()-> Void)?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupUI()
//
//    }
//    func setupUI(){
//        self.setTitle("", for: .normal)
//        self.setImage(UIImage(named: "ic_back_white"), for: .normal)
//        self.addTarget(self, action: #selector(setFunction), for: .touchUpInside)
//    }
//   @objc func setFunction(){
//           callback?()
//    }
//
//
//}
//class LableTitle : UILabel{
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }
//    func setup(){
//        self.textAlignment = .center
//        self.textColor = .white
//        self.font = UIFont(name: "Inter-SemiBold", size: 18)
//        self.numberOfLines = 2
//    }
//}
//class LableRequired : UILabel{
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    func setupLableRequired(){
//        let attr = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
//        let mulAttr = NSMutableAttributedString(string: self.text ?? "")
//        mulAttr.append(attr)
//        self.attributedText = mulAttr
//    }
//}
//class HiBottomView: UIView {
//
//    lazy var btnPrimary = ButtonPrimary()
//    lazy var viewBG = UIView()
//    var callbackActionButton : (()->Void)?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupUI()
//
//    }
//    func setupUI(){
//        self.backgroundColor = .white
//        viewBG.layer.shadowColor = UIColor.black.cgColor
//        viewBG.layer.shadowOffset = CGSize(width: 1, height: -3)
//        viewBG.layer.shadowOpacity = 0.1
//        viewBG.layer.cornerRadius = 12
//        viewBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        viewBG.backgroundColor = UIColor.white
//        viewBG.translatesAutoresizingMaskIntoConstraints = false
//        btnPrimary.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(viewBG)
//        self.addSubview(btnPrimary)
//        NSLayoutConstraint.activate([
//            viewBG.topAnchor.constraint(equalTo: self.topAnchor),
//            viewBG.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            viewBG.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            viewBG.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//
//            btnPrimary.centerXAnchor.constraint(equalTo: viewBG.centerXAnchor),
//            btnPrimary.centerYAnchor.constraint(equalTo: viewBG.centerYAnchor),
//            btnPrimary.widthAnchor.constraint(equalTo: viewBG.widthAnchor, multiplier: 382.0/414.0),
//            btnPrimary.heightAnchor.constraint(equalTo: viewBG.heightAnchor, multiplier: 48/84),
//
//        ])
//        btnPrimary.addTarget(self, action: #selector(setFunction), for: .touchUpInside)
//    }
//    @objc func setFunction(){
//        callbackActionButton?()
//    }
//}
//
//class HiBottomViewWithTwoButton: UIView {
//
//    lazy var btnPrimary = ButtonPrimary()
//    lazy var btnSecondary = ButtonWithBorder()
//    lazy var viewBG = UIView()
//    var callbackPrimaryBtn : (()->Void)?
//    var callbackSecondaryButton : (()->Void)?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupUI()
//
//    }
//    func setupUI(){
//        self.backgroundColor = .white
//        viewBG.layer.shadowColor = UIColor.black.cgColor
//        viewBG.layer.shadowOffset = CGSize(width: 1, height: -3)
//        viewBG.layer.shadowOpacity = 0.1
//        viewBG.layer.cornerRadius = 12
//        viewBG.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        viewBG.backgroundColor = UIColor.white
//        viewBG.translatesAutoresizingMaskIntoConstraints = false
//        btnPrimary.translatesAutoresizingMaskIntoConstraints = false
//        btnSecondary.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(viewBG)
//        self.addSubview(btnPrimary)
//        self.addSubview(btnSecondary)
//        NSLayoutConstraint.activate([
//            viewBG.topAnchor.constraint(equalTo: self.topAnchor),
//            viewBG.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            viewBG.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            viewBG.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//
////            btnPrimary.centerXAnchor.constraint(equalTo: viewBG.centerXAnchor),
//            btnSecondary.centerYAnchor.constraint(equalTo: viewBG.centerYAnchor),
//            btnSecondary.leadingAnchor.constraint(equalTo: viewBG.leadingAnchor,constant: 16),
//            btnSecondary.widthAnchor.constraint(equalTo: viewBG.widthAnchor, multiplier: 183.0/414.0),
//            btnSecondary.heightAnchor.constraint(equalTo: viewBG.heightAnchor, multiplier: 48/84),
//            btnPrimary.leadingAnchor.constraint(equalTo: btnSecondary.trailingAnchor,constant: 16),
//            btnPrimary.trailingAnchor.constraint(equalTo: viewBG.trailingAnchor, constant: -16),
//            btnPrimary.centerYAnchor.constraint(equalTo: viewBG.centerYAnchor),
//            btnPrimary.widthAnchor.constraint(equalTo: viewBG.widthAnchor, multiplier: 183.0/414.0),
//            btnPrimary.heightAnchor.constraint(equalTo: viewBG.heightAnchor, multiplier: 48/84),
//
//        ])
//        btnPrimary.addTarget(self, action: #selector(setFunctionForPrimaryBtn), for: .touchUpInside)
//        btnSecondary.addTarget(self, action: #selector(setFunctionForSecondBtn), for: .touchUpInside)
//    }
//    @objc func setFunctionForPrimaryBtn(){
//        callbackPrimaryBtn?()
//    }
//
//    @objc func setFunctionForSecondBtn(){
//        callbackSecondaryButton?()
//    }
//}
