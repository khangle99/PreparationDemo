//
//  PCUserDetailViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 10/01/2023.
//

import UIKit

class PCUserDetailViewController: CustomHeightViewController {

    var isAdvanced: Bool = true

    @IBOutlet weak var userDetailTbv: UITableView!
    
//    @IBOutlet weak var userNameLbl: UILabel!
//    @IBOutlet weak var profileTitleLbl: UILabel!
//    @IBOutlet weak var userAvatar: AvatarView!
//    @IBOutlet weak var profileImgView: UIImageView!
    
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var deleteUserBtn: UIView!
    @IBOutlet weak var connectionBtn: UIView!
    
    @IBOutlet weak var connectionImgView: UIImageView!
    
    @IBOutlet weak var connectionLbl: UILabel!
    
    private var deviceList: [PCDevice] = []
    
    private var bannedContent: [BannedContent] = []
    
    var user: PCUser? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userDetailTbv.contentInsetAdjustmentBehavior = .never
        title = "Chi tiết người dùng"
        setupNavigationBar()
        setupBottomView()
        setupUserDetailTableView()
        
        if let user = self.user {
            // fake api call
            mockData(user: user)
            //setupUserInfor(user: user)
            updateConnectionButton(user: user)
        }
    }
    
    private func updateConnectionButton(user: PCUser) {
        connectionImgView.image = user.isConnecting ? UIImage(named: "pause") : UIImage(named: "continue")
        connectionLbl.text = user.isConnecting ? "Ngưng" : "Tiếp tục"
    }
    
    private func setupUserDetailTableView() {
        userDetailTbv.registerNib(of: UserInfoCell.self)
        userDetailTbv.registerNib(of: BannedContentCell.self)
        userDetailTbv.registerNib(of: UserDeviceCell.self)
        userDetailTbv.registerNib(of: ChartInfoCell.self)
        userDetailTbv.registerNib(of: TimeLimitCell.self)
        userDetailTbv.tableHeaderView =
        UIView(frame: CGRect(x: 0, y: 0, width: userDetailTbv.frame.width, height: CGFloat.leastNormalMagnitude))
        userDetailTbv.tableFooterView =
        UIView(frame: CGRect(x: 0, y: 0, width: userDetailTbv.frame.width, height: CGFloat.leastNormalMagnitude))
        userDetailTbv.contentInsetAdjustmentBehavior = .never

        
        userDetailTbv.delegate = self
        userDetailTbv.dataSource = self
        userDetailTbv.allowsSelection = false
    }
    
   // @IBOutlet weak var bottomView: HiBottomView!
    
    private func setupBottomView() {
        bottomView.layer.cornerRadius = 16
        
        // bottom button gesture
        let deleteTapGes = UITapGestureRecognizer(target: self, action: #selector(deleteUserTapped(sender:)))
        deleteUserBtn.addGestureRecognizer(deleteTapGes)
        
        let connectionTapGes = UITapGestureRecognizer(target: self, action: #selector(connectionTapped(sender:)))
        connectionBtn.addGestureRecognizer(connectionTapGes)
    }
    
    @objc func deleteUserTapped(sender: UITapGestureRecognizer) {
        self.view.makeToast("Fake delete api call", point: .init(x: self.view.bounds.width/2, y: self.view.bounds.height - 150), title: nil, image: nil, completion: nil)
    }
    
    @objc func connectionTapped(sender: UITapGestureRecognizer) {
        user?.isConnecting.toggle()
        if let user = self.user {
            let isConnection = user.isConnecting
            userDetailTbv.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            self.view.makeToast(isConnection ? "Tiếp tục kết nối người dùng" : "Đã tạm ngưng người dùng", point: .init(x: self.view.bounds.width/2, y: self.view.bounds.height - 150), title: nil, image: nil, completion: nil)
            updateConnectionButton(user: user)
        }
        
    }
    
    private func setupNavigationBar() {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "edit"), for: .normal)
        btn.addTarget(self, action: #selector(editTapped(sender:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 18),
            btn.heightAnchor.constraint(equalToConstant: 18)
        ])
        let barButton = UIBarButtonItem(customView: btn)
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func editTapped(sender: UIButton) {
        print("edit tapped")
        if let user = self.user {
            let vc = EditUserViewController(user: user)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // fake call api
    private func mockData(user: PCUser) {
        self.deviceList = [
            .init(deviceName: "Sam ZFold3", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone"),
            .init(deviceName: "Vivobook", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone", assigneeId: "someUserId2"),
            .init(deviceName: "Iphone8", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone"),
            .init(deviceName: "Thinkpad", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone"),
        ]
        
        self.bannedContent = [
            .init(id: "id1", name: "Gambling", imgURL: "gambling"),
            .init(id: "id2", name: "Porn", imgURL: "p*rn"),
            .init(id: "id3", name: "Ad Block", imgURL: "adblock"),
        ]
    }

}

extension PCUserDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isAdvanced ? 4 : 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isAdvanced {
            switch section {
            case 0:
                return 2
            case 1:
                return deviceList.count
            case 2:
                return 1
            case 3:
                return bannedContent.count
            default:
                return 0
            }
        } else {
            switch section {
            case 0:
                return 1
            case 1:
                return deviceList.count
            case 2:
                return bannedContent.count
            default:
                return 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isAdvanced {
            switch indexPath.section {
            case 0:
                if indexPath.row == 0 { // header
                    let cell: UserInfoCell = tableView.dequeue(for: indexPath)
                    if let user = self.user {
                        cell.configure(user: user)
                    }
                    return cell
                } else { // chart
                    let cell: ChartInfoCell = tableView.dequeue(for: indexPath)
                    cell.configure(with: 4)
                    return cell
                }
               
            case 1:
                let cell: UserDeviceCell = tableView.dequeue(for: indexPath)
                cell.configure(device: deviceList[indexPath.row])
                return cell
            case 2:
                let cell: TimeLimitCell = tableView.dequeue(for: indexPath)
                return cell
            case 3:
                let cell: BannedContentCell = tableView.dequeue(for: indexPath)
                cell.configure(bannedContent[indexPath.row])
                return cell
            
            default:
                return .init()
            }
        } else {
            switch indexPath.section {
            case 0:
                let cell: UserInfoCell = tableView.dequeue(for: indexPath)
                if let user = self.user {
                    cell.configure(user: user)
                }
                return cell
            case 1:
                let cell: UserDeviceCell = tableView.dequeue(for: indexPath)
                cell.configure(device: deviceList[indexPath.row])
                return cell
            case 2:
                let cell: BannedContentCell = tableView.dequeue(for: indexPath)
                cell.configure(bannedContent[indexPath.row])
                return cell
            default:
                return .init()
            }
        }
        
    }
    
    
}

extension PCUserDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? CGFloat.leastNormalMagnitude : 58
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return indexPath.row == 0  ? 72 : 700
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isAdvanced {
            switch section {
            case 1:
                return createHeaderView(label: "Thiết bị đã gắn", tableView: tableView)
            case 2:
                return createHeaderView(label: "Giới hạn thời gian", tableView: tableView)
            case 3:
                return createHeaderView(label: "Nội dung chặn", tableView: tableView)
            default:
                return nil
            }
        } else {
            switch section {
            case 1:
                return createHeaderView(label: "Thiết bị đã gắn", tableView: tableView)
            case 2:
                return createHeaderView(label: "Nội dung chặn", tableView: tableView)
            default:
                return nil
            }
        }
       
    }
    
    func createHeaderView(label str: String, tableView: UITableView) -> UIView {
        
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = .clear
        let tableViewSize = tableView.bounds.size
       
        // blank
        let blank = UIView(frame: .init(origin: .zero, size: .init(width: tableViewSize.width, height: 12)))
        blank.backgroundColor = .clear
        sectionHeader.addSubview(blank)
        // title
        let titleContainer = UIView(frame: .init(origin: .init(x: 0, y: blank.frame.maxY), size: .init(width: tableViewSize.width, height: 44)))
        titleContainer.backgroundColor = .white
        
        let titleLabel = UILabel(frame: .init(origin: .init(x: 16, y: 0), size: .init(width: tableViewSize.width, height: 44)))
        titleLabel.textColor = Colors.textPrimary
        titleLabel.textAlignment = .left
        titleLabel.font = Font.semiBoldInter(of: 14)
        titleLabel.text = str
        titleContainer.addSubview(titleLabel)
        
        sectionHeader.addSubview(titleContainer)
        //separator
        let separator = UIView(frame: .init(origin: .init(x: 0, y: titleContainer.frame.maxY), size: .init(width: tableViewSize.width, height: 1)))
        separator.backgroundColor = Colors.line
        sectionHeader.addSubview(separator)
        
        return sectionHeader
    }
}
