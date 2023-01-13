//
//  PhotoSourceViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 12/01/2023.
//

import UIKit

// will be replaced by current hifpt bts
class PhotoSourceViewController: UIViewController {
    
    weak var delegate: PhotoSourceViewControllerDelegate?
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var uploadFromDeviceBtn: UIView!
    @IBOutlet weak var takePhotoBtn: UIView!
    
    @IBOutlet weak var closeBtn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentView.layer.cornerRadius = 16
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        let uploadGes = UITapGestureRecognizer(target: self, action: #selector(uploadTapped(sender:)))
        uploadFromDeviceBtn.addGestureRecognizer(uploadGes)
        
        let takePhotoGes =  UITapGestureRecognizer(target: self, action: #selector(takePhotoTapped(sender:)))
        takePhotoBtn.addGestureRecognizer(takePhotoGes)
        
        let closeGes = UITapGestureRecognizer(target: self, action: #selector(closeTapped(sender:)))
        closeBtn.addGestureRecognizer(closeGes)
    }
    
    @objc func closeTapped(sender: UIView) {
        dismiss(animated: true)
    }
    
    @objc func uploadTapped(sender: UIView) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func takePhotoTapped(sender: UIView) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension PhotoSourceViewController:  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image.size)
        self.view.makeToast("Fake upload api", point: .init(x: self.view.bounds.width/2, y: self.view.bounds.height - 150), title: nil, image: nil, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.delegate?.didSelectImage(image: image)
            self.dismiss(animated: true)
        }
        picker.dismiss(animated: true)
    }
}


protocol PhotoSourceViewControllerDelegate: AnyObject {
    func didSelectImage(image: UIImage)
}
