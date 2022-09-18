//
//  LoginViewController.swift
//  Pokedex
//
//  Created by Gabriel on 11/09/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passWordTxtField: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    @IBOutlet weak var cadastrarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passWordTxtField.delegate = self
        corneBotoes()
        botaoDesativado()
        view.backgroundColor = UIColor(red: 118/255, green: 204/255, blue: 232/255, alpha: 1.0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func didTapLoginButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "TabBar")
        navigationController?.pushViewController(viewcontroler, animated: true)
    }
    
    func botaoDesativado() {
        if emailTxtField.text == "" || passWordTxtField.text == "" {
            entrarButton.isEnabled = false
            entrarButton.backgroundColor = UIColor(red: 92/255, green: 94/255, blue: 100/255, alpha: 1.0)
        } else {
            entrarButton.isEnabled = true
            entrarButton.backgroundColor = UIColor(red: 29/255, green: 44/255, blue: 94/255, alpha: 1.0)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(self.emailTxtField) {
            self.emailTxtField.becomeFirstResponder()
            self.passWordTxtField.becomeFirstResponder()
        } else {
            self.passWordTxtField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        botaoDesativado()
    }
    
    func corneBotoes() {
        entrarButton.layer.cornerRadius = 19
        cadastrarButton.layer.cornerRadius = 19
    }
}

