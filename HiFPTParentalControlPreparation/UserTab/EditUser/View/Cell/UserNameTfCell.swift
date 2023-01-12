//
//  UserNameTfCell.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 11/01/2023.
//

import UIKit

class UserNameTfCell: UICollectionViewCell {
    
    
    @IBOutlet weak var nameTextfield: TextField!
    var onTextChange: ((String) -> Void)?
    
    func configure(with name: String) {
        nameTextfield.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // text echange event
        nameTextfield.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        nameTextfield.delegate = self
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        onTextChange?(nameTextfield.text ?? "")
    }
    
}

extension UserNameTfCell: NibLoadableView {}

extension UserNameTfCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if nameTextfield === textField {
            // check length
            let currentStr = (textField.text ?? "") as NSString
            let newStr = currentStr.replacingCharacters(in: range, with: string)

            if newStr.count <= Constant.TextField.maxLength {
                // validate
                return isValidPassword(newStr)
            } else {
                return false
            }
        }

        return true
    }

    func isValidPassword(_ str: String) -> Bool {
        let regex = Constant.TextField.regex
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: str)
    }
}

fileprivate struct Constant {
    struct TextField {
        static let regex = "[. a-zA-z0-9àáãạảăắằẳẵặâấầẩẫậèéẹẻẽêềếểễệđìíĩỉịòóõọỏôốồổỗộơớờởỡợùúũụủưứừửữựỳỵỷỹýÀÁÃẠẢĂẮẰẲẴẶÂẤẦẨẪẬÈÉẸẺẼÊỀẾỂỄỆĐÌÍĨỈỊÒÓÕỌỎÔỐỒỔỖỘƠỚỜỞỠỢÙÚŨỤỦƯỨỪỬỮỰỲỴỶỸÝ@-]*"
        
        static let maxLength = 50
    }
}
