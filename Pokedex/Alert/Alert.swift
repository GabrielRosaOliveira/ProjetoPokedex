//
//  Alert.swift
//  Pokedex
//
//  Created by Gabriel on 01/11/22.
//


import UIKit

class Alert {
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func configAlert(title: String, message: String, secondButton: Bool, completion:(() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            completion?()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.controller.dismiss(animated: true)
        }
        if secondButton {
            alertController.addAction(cancel)
        }
        alertController.addAction(ok)
        self.controller.present(alertController, animated: true, completion: nil)
        
    }
}
