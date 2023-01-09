//
//  BaseViewController.swift
//  HiFPTParentalControlPreparation
//
//  Created by Khang L on 06/01/2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide back title
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }

}
