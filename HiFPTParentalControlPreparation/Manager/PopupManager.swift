////
////  PopupManager.swift
////  HiThemes
////
////  Created by Trinh Quang Hiep on 10/11/2022.
////
//
//import Foundation
//import UIKit
///// HiThemesSDK
//public class HiThemesPopupManager{
//
//    private static let myLock = NSLock()
//    private static var instance : HiThemesPopupManager?
//
//    public static func share() -> HiThemesPopupManager {
//        if instance == nil {
//            myLock.lock()
//            if instance == nil {
//                instance = HiThemesPopupManager()
//            }
//            myLock.unlock()
//        }
//        return instance ?? HiThemesPopupManager()
//
//    }
//
//    private init() {
//    }
//    deinit {
//        debugPrint("---------------\(String(describing: type(of: self))) disposed-------------")
//    }
//    public func test(vc: UIViewController){
//        self.presentPopupWithTextBoxVC(vc: vc, titlePopup: "Test", placeholderContent: "ted aqwehj ksidiue die", currentContent: "Content", errorText: "Tên thiết bị không đúng định dạng", titleLeftButton: "left", actionLeftButton: {}, titleRightButton: "right", actionRightButton: {_ in }) {
//
//        }
//    } /// Popup with form send note
//    public func presentPopupWithTextBoxVC(vc: UIViewController, titlePopup: String,placeholderContent: String,currentContent:String?,errorText: String, titleLeftButton: String, actionLeftButton :(()->Void)?,titleRightButton: String, actionRightButton :((String)->Void)?, actionClose:(()->Void)? ){
//
//        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle(for: HiThemesPopupManager.self)).instantiateViewController(withIdentifier: "PopupWithTextBoxVC") as? PopupWithTextBoxVC else {return}
//        vcPopup.setupUIWithRawData(title: titlePopup,
//                                   currentContent: currentContent,
//                                   placeHolder: placeholderContent,
//                                   errorText: errorText ,
//                                   titleLeftBtn: titleLeftButton ,
//                                   titleRightBtn: titleRightButton,
//                                   actionLeftBtn: actionLeftButton,
//                                   actionRightBtn: actionRightButton )
//        vcPopup.modalPresentationStyle = .overFullScreen
//        vc.present(vcPopup, animated: false)
//    }
// /// Popup with form send note
//    public func presentPopupSendNoteVC(vc: UIViewController, titlePopup: String,placeholderContent: String,currentContent:String?, titleButton: String, actionButton :((String)->Void)?, actionClose:(()->Void)? ){
//
//        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle(for: HiThemesPopupManager.self)).instantiateViewController(withIdentifier: "PopupSendNoteVC") as? PopupSendNoteVC else {return}
//        vcPopup.titlePopup = titlePopup
//        vcPopup.titleButton = titleButton
//        vcPopup.placeHolderTextView = placeholderContent
//        vcPopup.currentContent = currentContent
//        vcPopup.callbackActionPrimary = actionButton
//        vcPopup.callbackClosePopup = actionClose
//        vcPopup.modalPresentationStyle = .overFullScreen
//        vc.present(vcPopup, animated: false)
//    }
//
//    ///Popup with list item ( item has lable title , tile content , can not select item )
//    public func presentToPopupWithListItemCustomVC(vc:UIViewController,
//                                             titlePopup: String,
//                                             listItem : [HiThemesCustomTitleContentCellProtocol],
//                                             callbackClosePopup : (()->Void)?,
//                                             actionClose : (()->Void)? = nil){
//        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle(for: HiThemesPopupManager.self)).instantiateViewController(withIdentifier: "PopupWithListItemCustomVC") as? PopupWithListItemCustomVC else {return}
//        vcPopup.titlePopup = titlePopup
//        vcPopup.listData = listItem
//        vcPopup.callbackClosePopup = callbackClosePopup
//        vcPopup.modalPresentationStyle = .overFullScreen
//        vc.present(vcPopup, animated: false)
//    }
//
//    ///Popup with list item ( item has many type UI , can select item )
//    public func presentToPopupWithListItemVC(vc:UIViewController,
//                                             uiModel: DataUIPopupWithListModel,
//                                             listItem : [HiThemesImageTitleIconProtocol],
//                                             indexOfItemSelected : Int?,
//                                             callbackClosePopup : (()->Void)?,
//                                             callbackDidSelectItem:((Int)->Void)?,
//                                             actionClose : (()->Void)? = nil,
//                                             callbackActionLeftButton : (()->Void)? = nil,
//                                             callbackActionRightButton : ((Int?)->Void)? = nil){
//        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle(for: HiThemesPopupManager.self)).instantiateViewController(withIdentifier: "PopupWithListItemVC") as? PopupWithListItemVC else {return}
//        vcPopup.dataUIPopupModel = uiModel
//        vcPopup.listData = listItem
//        vcPopup.currentIndexSelected = indexOfItemSelected
//        vcPopup.callbackClosePopup = callbackClosePopup
//        vcPopup.callbackDidSelectItem =  callbackDidSelectItem
//        vcPopup.callbackActionLeftButton = callbackActionLeftButton
//        vcPopup.callbackActionRightButton = callbackActionRightButton
//        vcPopup.modalPresentationStyle = .overFullScreen
//        vc.present(vcPopup, animated: false)
//    }
//    /// popup common ( title , content , 2 button , image)
//    public func presentToPopupVC(vc:UIViewController, type: HiThemesPopupType, isCountdown : Bool = false,
//                                 countdownTime : Int = 5, actionClose : (()->Void)? = nil){
//        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle(for: HiThemesPopupManager.self)).instantiateViewController(withIdentifier: "PopupVC") as? PopupVC else {return}
//        vcPopup.isCountdown = isCountdown
//        vcPopup.countdownTime = countdownTime
//        vcPopup.setupUI(popupType: type, actionClose: actionClose)
//        vcPopup.modalPresentationStyle = .overFullScreen
//         vc.present(vcPopup, animated: false)
//    }
//    ///image = nil > hidden,
//    ///left button title = nil > left button hidden + right button change full width,
//    ///left button titl = "" > left button hidden + right button not change,
//    public func presentToPopupVCWithRawData(vc:UIViewController,
//                                            title: String,
//                                            content: NSMutableAttributedString,
//                                            image : UIImage?,
//                                            isCountdown : Bool = false,
//                                            countdownTime : Int = 5,
//                                            titleLeftBtn: String?,
//                                            titleRightBtn: String,
//                                            actionLeftBtn: (()->Void)?,
//                                            actionRightBtn: @escaping (()->Void),
//                                            actionClose : (()->Void)? = nil){
//        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle(for: HiThemesPopupManager.self)).instantiateViewController(withIdentifier: "PopupVC") as? PopupVC else {return}
//        vcPopup.isCountdown = isCountdown
//        vcPopup.countdownTime = countdownTime
//        vcPopup.setupUIWithRawData(title: title,
//                                   content: content,
//                                   image: image,
//                                   titleLeftBtn: titleLeftBtn,
//                                   titleRightBtn: titleRightBtn,
//                                   actionLeftBtn: actionLeftBtn,
//                                   actionRightBtn: actionRightBtn,
//                                   actionClose: actionClose)
//
//        vcPopup.modalPresentationStyle = .overFullScreen
//         vc.present(vcPopup, animated: false)
//    }
//    /// popup with image big size ( title , content , 2 button , image)
//    public func presentToPopupWithImageVC(vc:UIViewController,
//                                          titlePopup: String,
//                                          contentPopup: NSMutableAttributedString,
//                                          imagePopup: UIImage,
//                                          rightBtnTitle: String){
//        guard let vcPopup = UIStoryboard(name: "Popup", bundle: Bundle(for: HiThemesPopupManager.self)).instantiateViewController(withIdentifier: "PopupWithImageVC") as? PopupWithImageVC else {return}
//        vcPopup.setupDataUI(titlePopup: titlePopup,
//                            contentPopup: contentPopup,
//                            imagePopup: imagePopup,
//                            rightBtnTitle: rightBtnTitle)
//        vcPopup.modalPresentationStyle = .overFullScreen
//         vc.present(vcPopup, animated: false)
//    }
//}
