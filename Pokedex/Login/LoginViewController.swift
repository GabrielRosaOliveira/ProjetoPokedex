//
//  LoginViewController.swift
//  Pokedex
//
//  Created by Gabriel on 11/09/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let user = Auth.auth().currentUser
    let fireStore = Firestore.firestore()
    var auth: Auth?
    var alert: Alert?
    var eyeClicked = false
    let imageEye = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFieldDelegate()
        corneBotoes()
        disabledButton()
        view.backgroundColor = UIColor(red: 118/255, green: 204/255, blue: 232/255, alpha: 1.0)
        self.auth = Auth.auth()
        eyeMagic()
        alert = Alert(controller: self)
    }
    
    func configTextFieldDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func eyeMagic() {
        imageEye.image = UIImage(systemName: "eye.slash")
        
        let contentView = UIView()
        contentView.addSubview(imageEye)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        
        imageEye.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageEye.isUserInteractionEnabled = true
        imageEye.addGestureRecognizer(tapGestureRecognizer)
        
        passwordTextField.isSecureTextEntry = true
    }
    
    @objc func imageTapped(tapGestureRecognizer:UITapGestureRecognizer) {
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if eyeClicked {
            eyeClicked = false
            tappedImage.image = UIImage(systemName: "eye.fill")
            passwordTextField.isSecureTextEntry = false
        } else {
            eyeClicked = true
            tappedImage.image = UIImage(systemName: "eye.slash")
            passwordTextField.isSecureTextEntry = true
        }
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
    
    fileprivate func doLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "TabBar") as? MyTabBarConstroller
        self.navigationController?.pushViewController(viewcontroler ?? UIViewController(), animated: true)
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        self.auth?.signIn(withEmail: email, password: password, completion: { (usuario, error) in
            
            if error != nil {
                
                self.alert?.configAlert(title: "Atenção", message: "Dados incorretos, tente novamente", secondButton: false)
            } else {
                if usuario == nil {
                    self.alert?.configAlert(title: "Atenção", message: "Tivemos um problema inesperado", secondButton: false)
                } else {
                    self.doLogin()
                }
            }
        })
    }
    
    func disabledButton() {
        if emailTextField.text == "" || passwordTextField.text == "" {
            goButton.isEnabled = false
            goButton.backgroundColor = UIColor(red: 92/255, green: 94/255, blue: 100/255, alpha: 1.0)
        } else {
            goButton.isEnabled = true
            goButton.backgroundColor = UIColor(red: 29/255, green: 44/255, blue: 94/255, alpha: 1.0)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(self.emailTextField) {
            self.emailTextField.becomeFirstResponder()
            self.passwordTextField.becomeFirstResponder()
        } else {
            self.passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        disabledButton()
    }
    
    func corneBotoes() {
        goButton.layer.cornerRadius = 19
        registerButton.layer.cornerRadius = 19
    }
}
