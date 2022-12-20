//
//  Alert.swift
//  Pokedex
//
//  Created by Gabriel on 01/11/22.
//



import Foundation
import UIKit

class Alert {
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func configAlert(title: String, message: String, completion:(() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Cancelar", style: .default) { action in
            self.controller.dismiss(animated: true)
        }
        let ok = UIAlertAction(title: "Ok", style: .cancel) { action in
            completion?()
        }
        alertController.addAction(ok)
        alertController.addAction(cancelar)
        self.controller.present(alertController, animated: true, completion: nil)
        
    }
}
