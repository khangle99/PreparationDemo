//
//  EditUserViewControllerV2.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 11/01/2023.
//

import UIKit

class EditUserViewController: CustomHeightViewController {
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    let isNewUserMode: Bool
    var user: PCUser
   
    var userDevices: [PCDevice] = []
    
    @IBOutlet weak var updateBtn: UIButton!
    init(user: PCUser? = nil) {
        
        if let user = user {
            isNewUserMode = false
            self.user = user
        } else {
            isNewUserMode = true
            // validate this empty user to hceck user filled
            self.user = PCUser(userId: "", profile: .init(id: "", title: ""), userName: "", deviceCount: 0, imgURLString: "", isConnecting: false)
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBtn.setTitle(isNewUserMode ? "Tạo" : "Cập nhật", for: .normal)
        title = isNewUserMode ? "Thêm người dùng" : "Chỉnh sửa"
        if !isNewUserMode {
            userDevices = MockData.getMockDevice()
            collectionView.reloadData()
        }
        
        setupCollectionView()
        
        configureTapToDismiss()
    }
    
    private func configureTapToDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(outsideTapped(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func outsideTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    private func setupCollectionView() {
        collectionView.registerNib(of: PCAssignedDeviceCell.self)
        collectionView.registerNib(of: AddMoreDeviceCell.self)
        collectionView.registerNib(of: UserProfileCell.self)
        collectionView.registerNib(of: UserNameTfCell.self)
        collectionView.registerNib(of: AvatarHeaderCell.self)
        collectionView.registerNib(header: HeaderView.self)
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }

    @IBAction func updateTapped(_ sender: Any) {
        print("update tapped")
    }
}

extension EditUserViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 3 { // assigned device secion
            return userDevices.count + 1
        } else { // other section
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let avatarCell: AvatarHeaderCell = collectionView.dequeue(for: indexPath)
            avatarCell.configure(with: user.imgURLString != "" ? UIImage(named: user.imgURLString)! : UIImage(named: "quanly")!)
            
            avatarCell.onAvatarTapped = { [weak self] in
                print("avatar tapped")
                let vc = AvatarPickerViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            return avatarCell
        case 1:
            let nameTfCell: UserNameTfCell = collectionView.dequeue(for: indexPath)
            if user.userName != "" {
                nameTfCell.configure(with: user.userName)
            }
            
            nameTfCell.onTextChange = {[weak self] str in
                self?.user.userName = str
            }
            
            return nameTfCell
        case 2:
            let profileCell: UserProfileCell = collectionView.dequeue(for: indexPath)
            profileCell.configure(with: user.profile)
            profileCell.onTapped = { [weak self] in
                print("tapped profile")
            }
            
            return profileCell
        case 3:
            if indexPath.item == userDevices.count { // add more cell
                let addMoreCell: AddMoreDeviceCell = collectionView.dequeue(for: indexPath)
                addMoreCell.onCellTapped = {[weak self] in
                    print("add more tapped")
                }
                return addMoreCell
            } else {
                let deviceCell: PCAssignedDeviceCell = collectionView.dequeue(for: indexPath)
                
                deviceCell.configure(with: userDevices[indexPath.item])
                deviceCell.onRemoveTapped = { [weak self] device in
                    self?.view.makeToast("show delete popup", duration: 1.0, position: .bottom)
                    print("tapped device \(device.deviceName)")
                }
                
                return deviceCell
            }
           
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? .init(width: collectionView.bounds.width, height: 16)  : .init(width: collectionView.bounds.width, height: 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: HeaderView = collectionView.dequeueHeader(for: indexPath)
        
        switch indexPath.section {
        case 0:
            header.configure(with: "")
        case 1:
            header.configure(with: "Họ & tên")
        case 2:
            header.configure(with: "Loại hồ sơ")
        case 3:
            header.configure(with: "Thiết bị đã gắn")
        default:
            break
        }
        
        return header
    }
    
}

extension EditUserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 2 * Constant.CollectionView.horizontalPadding
        switch indexPath.section {
        case 0:
            return .init(width: width, height: 96)
        case 1, 2:
            return .init(width: width, height: 50)
        case 3:
            return .init(width: width, height: 64)
        default:
            return .zero
        }
    }
    
}

extension EditUserViewController: UICollectionViewDelegate {
    
}

fileprivate struct Constant {
    struct CollectionView {
        static let horizontalPadding: CGFloat = 16
    }
}
