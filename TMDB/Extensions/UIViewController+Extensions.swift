//
//  UIViewController+Extensions.swift
//  TMDB
//
//  Created by André Cocuroci on 23/11/18.
//  Copyright © 2018 Cocuroci. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(error: Error) {
        self.showSimpleAlert(title: "Atenção",
                             message: error.localizedDescription,
                             okTitle: "Entendi")
    }
    
    func showSimpleAlert(title: String, message: String, okTitle: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: okTitle, style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
