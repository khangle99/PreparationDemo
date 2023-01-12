//
//  PCUserDetailViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 10/01/2023.
//

import UIKit

class PCUserDetailViewController: BaseViewController {

    @IBOutlet weak var userAvatar: AvatarView!
    @IBOutlet weak var userDetailTbv: UITableView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var profileTitleLbl: UILabel!
    
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var deleteUserBtn: UIView!
    @IBOutlet weak var connectionBtn: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var connectionImgView: UIImageView!
    
    @IBOutlet weak var connectionLbl: UILabel!
    
    private var deviceList: [PCDevice] = []
    
    private var bannedContent: [BannedContent] = []
    
    var user: PCUser? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Chi tiết người dùng"
        setupNavigationBar()
        setupBottomView()
        setupUserDetailTableView()
        
        if let user = self.user {
            // fake api call
            mockData(user: user)
            setupUserInfor(user: user)
            updateConnectionButton(user: user)
        }
    }
    
    private func updateConnectionButton(user: PCUser) {
        connectionImgView.image = user.isConnecting ? UIImage(named: "pause") : UIImage(named: "continue")
        connectionLbl.text = user.isConnecting ? "Ngưng" : "Tiếp tục"
    }
    
    private func setupUserInfor(user: PCUser) {
        userNameLbl.adjustsFontSizeToFitWidth = true
        userNameLbl.text = user.userName
        
        userAvatar.avatarImage = UIImage(named: user.imgURLString)
        
        profileImgView.image = UIImage(named: user.profile.imageURLString)
        profileTitleLbl.text = user.profile.title
        
    }
    
    private func setupUserDetailTableView() {
        userDetailTbv.delegate = self
        userDetailTbv.dataSource = self
        userDetailTbv.registerNib(of: BannedContentCell.self)
        userDetailTbv.registerNib(of: UserDeviceCell.self)
        userDetailTbv.allowsSelection = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // cornerRadius
        userAvatar.imageCornerRadius = userAvatar.frame.height / 2
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
    
    @objc func deleteUserTapped(sender: UIView) {
        self.view.makeToast("Fake delete api call", point: .init(x: self.view.bounds.width/2, y: self.view.bounds.height - 150), title: nil, image: nil, completion: nil)
    }
    
    @objc func connectionTapped(sender: UIView) {
        user?.isConnecting.toggle()
        if let user = self.user {
            let isConnection = user.isConnecting
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
    }
    
    // fake call api
    private func mockData(user: PCUser) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
            self.userDetailTbv.reloadData()
        }
        
    }

}

extension PCUserDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return deviceList.count
        case 1:
            return bannedContent.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: UserDeviceCell = tableView.dequeue(for: indexPath)
            cell.configure(device: deviceList[indexPath.row])
            return cell
        case 1:
            let cell: BannedContentCell = tableView.dequeue(for: indexPath)
            cell.configure(bannedContent[indexPath.row])
            return cell
        default:
            return .init()
        }
    }
    
    
}

extension PCUserDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return createHeaderView(label: "Thiết bị đã gắn", tableView: tableView)
        case 1:
            return createHeaderView(label: "Nội dung chặn", tableView: tableView)
        default:
            return nil
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
