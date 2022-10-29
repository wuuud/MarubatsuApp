//
//  OkAlert.swift
//  MarubatsuApp
//
//  Created by H M on 2022/10/23.
//

import UIKit

class OkAlert: UIAlertController {
    func showOkAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
}
