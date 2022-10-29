//
//  CadastroViewController.swift
//  Pokedex
//
//  Created by Gabriel on 18/09/22.
//

import UIKit
import Firebase

class CadastroViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var camadaView: UIView!
    @IBOutlet weak var cadastroLabel: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var dataNascimentoTxtField: UITextField!
    @IBOutlet weak var passWordTxtField: UITextField!
    @IBOutlet weak var passWordNovamenteTxtField: UITextField!
    @IBOutlet weak var apelidoTxtField: UITextField!
    @IBOutlet weak var cadastrarButton: UIButton!
    
    var auth: Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inferiorBottoView()
        configButton()
        emailTxtField.delegate = self
        dataNascimentoTxtField.delegate = self
        passWordTxtField.delegate = self
        passWordNovamenteTxtField.delegate = self
        apelidoTxtField.delegate = self
        botaoDesativado()
        cornerRadius()
        self.auth = Auth.auth()
    }
    
    func configButton() {
        view.backgroundColor = UIColor(red: 20/255, green: 178/255, blue: 226/255, alpha: 1.0)
        cadastroLabel.textColor = UIColor(red: 253/255, green: 244/255, blue: 20/255, alpha: 1.0)
        camadaView.backgroundColor = UIColor(red: 118/255, green: 204/255, blue: 232/255, alpha: 1.0)
    }
    
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    

    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        
        let email: String = emailTxtField.text ?? ""
        let password: String = passWordTxtField.text ?? ""
        
        self.auth?.createUser(withEmail: email, password: password, completion: { (result, error)  in
            
            if error != nil {
                print("deu falaha")
            } else {
                print("sucesso")
            }
            
        })
        
    }
    
    func inferiorBottoView() {
        camadaView.layer.cornerRadius = 50
        camadaView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        camadaView.layer.borderWidth = 1.5
        camadaView.layer.borderColor = UIColor.black.cgColor
}
    
    func botaoDesativado() {
        if emailTxtField.text == "" || dataNascimentoTxtField.text == "" || passWordTxtField.text == "" || passWordNovamenteTxtField.text == "" || apelidoTxtField.text == "" {
            cadastrarButton.isEnabled = false
            cadastrarButton.backgroundColor = UIColor(red: 92/255, green: 94/255, blue: 100/255, alpha: 1.0)
        } else {
            cadastrarButton.isEnabled = true
            cadastrarButton.backgroundColor = UIColor(red: 29/255, green: 44/255, blue: 94/255, alpha: 1.0)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
           if (textField == self.emailTxtField) {
               self.dataNascimentoTxtField.becomeFirstResponder()
           }
           else if (textField == self.dataNascimentoTxtField) {
               self.passWordTxtField.becomeFirstResponder()

           } else if (textField == self.passWordTxtField) {
               self.passWordNovamenteTxtField.becomeFirstResponder()
           }
        else if (textField == self.passWordNovamenteTxtField) {
            self.apelidoTxtField.becomeFirstResponder()
        }

           return true
       }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        botaoDesativado()
    }
    
    func cornerRadius() {
        cadastrarButton.layer.cornerRadius = 17
    }
}
