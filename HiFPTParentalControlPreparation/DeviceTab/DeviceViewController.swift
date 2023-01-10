//
//  DeviceViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 05/01/2023.
//

import UIKit

class DeviceViewController: BaseViewController {
    
    private var deviceStatus: [String] = [] {
        didSet {
            filterCollectionView.reloadData()
            selectedFilterIndex = 0 // reset
        }
    }
    
    private var selectedFilterIndex: Int = 0 {
        didSet {
            // first index is all
            switch selectedFilterIndex {
            case 0: // all
                filteredDeviceList = deviceList
            case 1:
                filteredDeviceList = assingedDevices
            case 2:
                filteredDeviceList = unAssignedDevices
                
            default:
                break
            }
            deviceListTableView.reloadData()
        }
    }
    
    private var filteredDeviceList: [PCDevice] = []
    
    private var assingedDevices: [PCDevice] = []
    private var unAssignedDevices: [PCDevice] = []
    private var deviceList: [PCDevice] = [] {
        didSet {
            unAssignedDevices = deviceList.filter { $0.assigneeId == nil }
            assingedDevices = deviceList.filter { $0.assigneeId != nil }
            
            let allTitle = deviceList.count != 0 ? "Tất cả (\(deviceList.count))" : "Tất cả"
            let unAssignedTitle = unAssignedDevices.count != 0 ? "Chưa được gán (\(unAssignedDevices.count))" : "Chưa được gán"
            let assignedTitle = assingedDevices.count != 0 ? "Được gán (\(assingedDevices.count))" : "Được gán"
            deviceStatus = [allTitle, assignedTitle, unAssignedTitle]
        }
    }
    
    
    @IBOutlet weak var cvLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    @IBOutlet weak var deviceListTableView: UITableView!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        let attStr = NSAttributedString(string: "Pull to refresh", attributes: [.foregroundColor: Colors.appPrimary])
        refresh.attributedTitle = attStr
        refresh.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    @objc func refresh(sender: UIRefreshControl) {
        // fake api call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.deviceList
            = MockData.getMockDevice()
            self.refreshControl.endRefreshing()
            self.selectedFilterIndex = 0 // reset to all
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDeviceFilterCV()
        setupDeviceListTableView()
        deviceList = MockData.getMockDevice()
    }
    
    private func setupDeviceListTableView() {
        deviceListTableView.delegate = self
        deviceListTableView.dataSource = self
        deviceListTableView.registerNib(of: DeviceCell.self)
        deviceListTableView.rowHeight = UITableView.automaticDimension
        deviceListTableView.allowsSelection = false
        
        deviceListTableView.addSubview(refreshControl)
    }
    
    private func setupDeviceFilterCV() {
        cvLayout.scrollDirection = .horizontal
        cvLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        filterCollectionView.backgroundColor = .clear
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.registerNib(of: FilterCell.self)
    }

}
// MARK: Filter List
extension DeviceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deviceStatus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as? FilterCell else { return .init() }
        cell.configure(filterData: .init(title: deviceStatus[indexPath.item], imgUrl: ""), isSelect: indexPath.row == selectedFilterIndex)
        return cell
    }
}

extension DeviceViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oldIndex = IndexPath(item: selectedFilterIndex, section: 0)
        selectedFilterIndex = indexPath.item
        let newIndex = indexPath
        // update state
        if let oldCell = collectionView.cellForItem(at: oldIndex) as? FilterCell {
            oldCell.configure(filterData: .init(title: deviceStatus[oldIndex.item], imgUrl: ""), isSelect: false)
        }
        if let newCell = collectionView.cellForItem(at: newIndex) as? FilterCell {
            newCell.configure(filterData: .init(title: deviceStatus[newIndex.item], imgUrl: ""), isSelect: true)
        }
    }
}

// MARK: Device list
extension DeviceViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredDeviceList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DeviceCell = tableView.dequeue(for: indexPath)
        cell.configure(device: filteredDeviceList[indexPath.section])
        
//        cell.onDeleteUserTapped = { [weak self] user in
//            guard let `self` = self else { return }
//
//            self.view.makeToast("Show delete user confirm popup", point: .init(x: self.view.bounds.width/2, y: self.view.bounds.height - 150), title: nil, image: nil, completion: nil)
//        }
//
//        cell.onConnectTapped = { [weak self] user in
//            guard let `self` = self else { return }
//
//            // fake api call
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//
//                let user = self.filteredDeviceList[indexPath.section]
//                let isConnection = user.isConnecting
//
//                guard let index = self.userList.firstIndex(where: {$0.userId == user.userId}) else { return }
//
//                self.userList[index].isConnecting = !isConnection
//
//                self.view.makeToast(!isConnection ? "Tiếp tục kết nối người dùng" : "Đã tạm ngưng người dùng", point: .init(x: self.view.bounds.width/2, y: self.view.bounds.height - 150), title: nil, image: nil, completion: nil)
//            }
//        }
//
//        cell.onCellTapped = { [weak self] user in
//            let vc = BaseViewController()
////            self?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//            //navigationItem.backButtonDisplayMode = .minimal
//            vc.view.backgroundColor = .red
//            self?.navigationController?.pushViewController(vc, animated: true)
//        }
        
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

extension DeviceViewController: UITableViewDelegate {
    
}


