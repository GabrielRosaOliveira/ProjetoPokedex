//
//  EsqueceuSenhaViewController.swift
//  Pokedex
//
//  Created by Gabriel on 18/09/22.
//

import UIKit

class ForgotPasswordViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sentEmailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentEmailButton.layer.cornerRadius = 15
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func tappedSendButton(_ sender: UIButton) {
        if emailTextField.isEnabled{
            let alertEditing = UIAlertController(title: "Atenção", message: "Enviamos um e-mail para \( emailTextField.text ?? ""), com instruções de como redefinir sua senha", preferredStyle: UIAlertController.Style.alert)
            alertEditing.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertEditing,animated: true,completion: nil)
        }
    }
}
