//
//  UIViewController+Extension.swift
//  MLBusca
//
//  Created by Ricardo Gehrke Filho on 24/07/25.
//
import UIKit

extension UIViewController {
    func presentAlert(_ message: String, title: String = "Erro", actionTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
