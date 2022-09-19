//
//  EsqueceuSenhaViewController.swift
//  Pokedex
//
//  Created by Gabriel on 18/09/22.
//

import UIKit

class EsqueceuSenhaViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var sentEmailButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sentEmailButton.layer.cornerRadius = 15
        emailTextField.delegate = self
       
    }

    @IBAction func tappedBackButton(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    
    
    

}
