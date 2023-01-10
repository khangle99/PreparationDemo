//
//  UserViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 05/01/2023.
//

import UIKit
import Toast_Swift

class UserViewController: BaseViewController {
    
    // MARK: Mock
    private var filterList: [FilterData] = []
    
    var userList: [PCUser] = [] {
        didSet {
            var profiles: [PCProfile] = []
            // extract profile
            let group = Dictionary(grouping: userList, by: {$0.profile.id})
            group.forEach { key, items in
                
            }
            userList.map { $0.profile }.forEach { profile in
                if !profiles.contains(where: {$0.title == profile.title} ) {
                    profiles.append(profile)
                }
            }
            
            profileList = profiles
        }
    }
    

    private var selectedFilterIndex: Int = 0 {
        didSet {
            // first index is all
            if selectedFilterIndex == 0 {
                filteredUserList = userList
            } else {
                // filter user
                let profile = profileList[selectedFilterIndex - 1]
                filteredUserList = userList.filter {$0.profile.id == profile.id}
            }
            //userListTableView.reloadData()
        }
    }
    
    private var filteredUserList: [PCUser] = []
    
    var profileList: [PCProfile] = [] {
        didSet {
            guard profileList.count > 0 else { return }
            
            let group = Dictionary(grouping: userList, by: {$0.profile.id})
            var profiles: [FilterData] = profileList.map { profile in
                var title = "\(profile.title)"
                
                if let count = group[profile.id]?.count {
                    title.append(" (\(count))")
                }
                return .init(title: title, imgUrl: profile.imageURLString)
            }
            
            profiles.insert(.init(title: "Tất cả (\(userList.count))", imgUrl: "all"), at: 0)
            
            filterList = profiles
            filterCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var cvLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    @IBOutlet weak var userListTableView: UITableView!
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        let attStr = NSAttributedString(string: "Pull to refresh", attributes: [.foregroundColor: Colors.appPrimary])
        refresh.attributedTitle = attStr
        refresh.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refresh
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        userList = MockData.getMockUser()

        setupProfileFilterCV()
        setupUserListTableView()
        selectedFilterIndex = 0
    }
    
    private func setupUserListTableView() {
        userListTableView.delegate = self
        userListTableView.dataSource = self
        userListTableView.registerNib(of: PCUserCell.self)
        userListTableView.rowHeight = UITableView.automaticDimension
        //userListTableView.allowsSelection = false
        
        userListTableView.addSubview(refreshControl)
    }
    
    private func setupProfileFilterCV() {
        cvLayout.scrollDirection = .horizontal
        cvLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        filterCollectionView.backgroundColor = .clear
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.registerNib(of: FilterCell.self)
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        // fake api call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.userList = MockData.getMockUser()
            self.refreshControl.endRefreshing()
            self.selectedFilterIndex = 0
            self.userListTableView.reloadData()
        }
    }
}

// MARK: Profile filter collectionview
extension UserViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterCell else { return .init() }
        cell.configure(filterData: filterList[indexPath.item], isSelect: indexPath.row == selectedFilterIndex)
        return cell
    }
}

extension UserViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oldIndex = IndexPath(item: selectedFilterIndex, section: 0)
        selectedFilterIndex = indexPath.item
        userListTableView.reloadData()
        let newIndex = indexPath
        // update state
        if let oldCell = collectionView.cellForItem(at: oldIndex) as? FilterCell {
            oldCell.configure(filterData: filterList[oldIndex.item], isSelect: false)
        }
        if let newCell = collectionView.cellForItem(at: newIndex) as? FilterCell {
            newCell.configure(filterData: filterList[newIndex.item], isSelect: true)
        }
    }
}

// MARK: User tableview
extension UserViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredUserList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PCUserCell = tableView.dequeue(for: indexPath)
        cell.configure(user: filteredUserList[indexPath.section])
        
        cell.onDeleteUserTapped = { [weak self] user in
            guard let `self` = self else { return }
            
            self.view.makeToast("Show delete user confirm popup", point: .init(x: self.view.bounds.width/2, y: self.view.bounds.height - 150), title: nil, image: nil, completion: nil)
        }
        
        cell.onConnectTapped = { [weak self] user in
            guard let `self` = self else { return }
            
            // fake api call
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                let user = self.filteredUserList[indexPath.section]
                let isConnection = user.isConnecting
                
                guard let index = self.userList.firstIndex(where: {$0.userId == user.userId}) else { return }
                
                self.userList[index].isConnecting = !isConnection
                self.selectedFilterIndex = self.selectedFilterIndex
                cell.configure(user: self.filteredUserList[indexPath.section])
                
                self.view.makeToast(!isConnection ? "Tiếp tục kết nối người dùng" : "Đã tạm ngưng người dùng", point: .init(x: self.view.bounds.width/2, y: self.view.bounds.height - 150), title: nil, image: nil, completion: nil)
            }
        }
        
        cell.onCellTapped = { [weak self] user in
            let vc = PCUserDetailViewController()
            vc.user = user
//            self?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            //navigationItem.backButtonDisplayMode = .minimal
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .clear
        return footer
    }

}

extension UserViewController: UITableViewDelegate {}

