//
//  PCUser.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 06/01/2023.
//

import Foundation

struct PCUser {
    var userId: String
    var profile: PCProfile
    var userName: String
    var deviceCount: Int
    var imgURLString: String
    
    var isConnecting = false
}

struct PCProfile {
    let id: String
    var title: String
    var imageURLString: String = ""
}


final class MockData {
    class func getMockUser() -> [PCUser] {
        let profiles: [PCProfile] = getMockProfiles()
        
        return [
            .init(userId: "uid1", profile: profiles[0], userName: "Nguyễn Trần Trung Quân Idol", deviceCount: 3, imgURLString: "sampleAvatar", isConnecting: true),
            .init(userId: "uid2", profile: profiles[1], userName: "Cô Minh Hiếu", deviceCount: 5, imgURLString: "sampleAvatar"),
            .init(userId: "uid3", profile: profiles[1], userName: "Trần Đức Bo", deviceCount: 7, imgURLString: "sampleAvatar", isConnecting: true),
            .init(userId: "uid4", profile: profiles[2], userName: "Mẹ", deviceCount: 1, imgURLString: "sampleAvatar", isConnecting: true),
            .init(userId: "uid5", profile: profiles[2], userName: "Ba", deviceCount: 2, imgURLString: "sampleAvatar"),
            .init(userId: "uid6", profile: profiles[2], userName: "Thằng Bi", deviceCount: 4, imgURLString: "sampleAvatar"),
        ]
    }
    
    class func getMockDevice() -> [PCDevice] {
        return [
            .init(deviceName: "Sam ZFold3", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone"),
            .init(deviceName: "Mac15", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone"),
            .init(deviceName: "Vivobook", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone"),
            .init(deviceName: "Iphone8", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone"),
            .init(deviceName: "S22 Ultra", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone"),
            .init(deviceName: "Thinkpad", macAddress: "MAC: 012-87-27-WW-2758", imageURLStr: "phone"),
        ]
    }
    
    class func getMockProfiles() -> [PCProfile] {
        return [
            .init(id: "ad1", title: "Người lớn", imageURLString: "adult"),
            .init(id: "child",title: "Trẻ em", imageURLString: "children"),
            .init(id: "ad", title: "Quản lý", imageURLString: "quanly"),
            .init(id: "empty", title: "Empty", imageURLString: "student")
        ]
    }
}
