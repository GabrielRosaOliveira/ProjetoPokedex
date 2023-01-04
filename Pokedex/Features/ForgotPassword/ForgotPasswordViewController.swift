//
//  EsqueceuSenhaViewController.swift
//  Pokedex
//
//  Created by Gabriel on 18/09/22.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sentEmailButton: UIButton!
    
    var auth: Auth?
    var alert: Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentEmailButton.layer.cornerRadius = 15
        auth = Auth.auth()
        alert = Alert(controller: self)
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func tappedSendButton(_ sender: UIButton) {
        auth?.sendPasswordReset(withEmail: emailTextField.text ?? "", completion: { error in
            if let error {
                self.alert?.configAlert(title: AlertTexts.errorTitle.rawValue, message: AlertTexts.errorMessage.rawValue, secondButton: false)
            } else {
                self.alert?.configAlert(title: AlertTexts.succeeded.rawValue, message: AlertTexts.titleSucceeded.rawValue, secondButton: false)
            }
        })
    }
}
