//
//  LoginViewController.swift
//  Pokedex
//
//  Created by Gabriel on 11/09/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passWordTxtField: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    @IBOutlet weak var cadastrarButton: UIButton!
    
    var auth: Auth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passWordTxtField.delegate = self
        corneBotoes()
        botaoDesativado()
        view.backgroundColor = UIColor(red: 118/255, green: 204/255, blue: 232/255, alpha: 1.0)
        self.auth = Auth.auth()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func didtapRegisterButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "RegisterStoryboard", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "Cadastro")
        navigationController?.pushViewController(viewcontroler, animated: true)
    }
    
    @IBAction func didtapForgotPasswordButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ForgotPasswordStoryboard", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "esqueceuSenha")
        navigationController?.pushViewController(viewcontroler, animated: true)
    }
    
    func alert(title: String, message: String) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }

    fileprivate func doLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "TabBar")
        self.navigationController?.pushViewController(viewcontroler, animated: true)
        print("login feito com sucesso")
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
        let email: String = emailTxtField.text ?? ""
        let password: String = passWordTxtField.text ?? ""
        
        self.auth?.signIn(withEmail: email, password: password, completion: { (usuario, error) in
            
            if error != nil {
                self.alert(title: "Atenção", message: "Dados incorretos, tente novamente")
                print("dados incorretos")
            } else {
                if usuario == nil {
                    self.alert(title: "Atenção", message: "Tivemos um problema inesperado")
                    print("problema")
                } else {
                    self.doLogin()
                }
            }
        })
        
        
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

