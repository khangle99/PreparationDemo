//
//  AvatarPickerViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 12/01/2023.
//

import UIKit

class AvatarPickerViewController: CustomHeightViewController {

    @IBOutlet weak var avatarCollectionView: UICollectionView!
    
    let defaultAvatarURLs: [String] = ["avatar-01", "avatar-02", "avatar-03", "avatar-04", "avatar-05", "avatar-06", "avatar-07", "avatar-08"]
    var userAvatarURLs: [String] = ["quanly"]
    var totalAvatarURL: [String] {
        return defaultAvatarURLs + userAvatarURLs
    }
    
    private var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Ảnh đại diện"
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        
        avatarCollectionView.registerNib(of: UploadSelectCell.self)
        avatarCollectionView.registerNib(of: AvatarCell.self)
        avatarCollectionView.registerNib(header: HeaderView.self)
        
        avatarCollectionView.delegate = self
        avatarCollectionView.dataSource = self
        
    }
}

// MARK: Datasource
extension AvatarPickerViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? totalAvatarURL.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let avatarCell: AvatarCell = collectionView.dequeue(for: indexPath)
            avatarCell.configure(with: UIImage(named: totalAvatarURL[indexPath.item])!, isSelected: selectedIndex == indexPath.item)
            return avatarCell
        case 1:
            let uploadCell: UploadSelectCell = collectionView.dequeue(for: indexPath)
            return uploadCell
        default:
            return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: HeaderView = collectionView.dequeueHeader(for: indexPath)
        switch indexPath.section {
        case 0:
            header.configure(with: "Chọn hình đại diện")
        case 1:
            header.configure(with: "Tải từ thiết bị")
        default:
            break
        }
        return header
    }
}

extension AvatarPickerViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: Item
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        if indexPath.section == 1 {
          
            return .init(width: width - 2 * Constant.CollectionView.spacing, height: Constant.CollectionView.uploadSelectCellHeight)
        } else {
            // calculate size: 1 row 3 cell with spacing
            let cellWidth = (width - 2 * Constant.CollectionView.avatarHSpacing - 2 * Constant.CollectionView.spacing)/3
            
            return .init(width: cellWidth, height: cellWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? Constant.CollectionView.avatarHSpacing : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? Constant.CollectionView.avatarHSpacing : 0
    }

    // MARK: Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.bounds.width, height: Constant.CollectionView.headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constant.CollectionView.sectionInset
    }
    
  
}

extension AvatarPickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            print("tap upload")
            
        } else {
            print(indexPath.item)
            if let oldIndex = self.selectedIndex, let oldCell = collectionView.cellForItem(at: .init(item: oldIndex, section: 0)) as? AvatarCell {
                oldCell.updateSelectState(isSelected: false)
            }
            
            if let newCell = collectionView.cellForItem(at: indexPath) as? AvatarCell {
                newCell.updateSelectState(isSelected: true)
            }
           
            selectedIndex = indexPath.item
        }
    }
}

fileprivate struct Constant {
    struct CollectionView {
        static let spacing: CGFloat = 16
        static let sectionInset: UIEdgeInsets = .init(top: 0, left: 16, bottom: 16, right: 16)
        static let uploadSelectCellHeight: CGFloat = 64
        
        static let headerHeight: CGFloat = 28
        
        static let avatarHSpacing: CGFloat = 23
        static let avatarVSpacing: CGFloat = 14
    }
}
