//
//  CadastroViewController.swift
//  Pokedex
//
//  Created by Gabriel on 18/09/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var auth: Auth?
    
    var eyeClicked = false
    let imageEye = UIImageView()
    
    var eyeClicked2 = false
    let imageEye2 = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView()
        configButton()
        emailTextField.delegate = self
        birthdayTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        nicknameTextField.delegate = self
        disabledButton()
        cornerRadius()
        self.auth = Auth.auth()
        eyeMagic()
        eyeMagic2()
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
    
    func eyeMagic2() {
        imageEye2.image = UIImage(systemName: "eye.slash")
        
        let contentView = UIView()
        contentView.addSubview(imageEye2)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        
        imageEye2.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        
        confirmPasswordTextField.rightView = contentView
        confirmPasswordTextField.rightViewMode = .always
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
        imageEye2.isUserInteractionEnabled = true
        imageEye2.addGestureRecognizer(tapGestureRecognizer)
        
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    @objc func imageTapped2(tapGestureRecognizer:UITapGestureRecognizer) {
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if eyeClicked2 {
            eyeClicked2 = false
            tappedImage.image = UIImage(systemName: "eye.fill")
            confirmPasswordTextField.isSecureTextEntry = false
        } else {
            eyeClicked2 = true
            tappedImage.image = UIImage(systemName: "eye.slash")
            confirmPasswordTextField.isSecureTextEntry = true
        }
    }
    
    func configButton() {
        view.backgroundColor = UIColor(red: 20/255, green: 178/255, blue: 226/255, alpha: 1.0)
        registerLabel.textColor = UIColor(red: 253/255, green: 244/255, blue: 20/255, alpha: 1.0)
        backGroundView.backgroundColor = UIColor(red: 118/255, green: 204/255, blue: 232/255, alpha: 1.0)
    }
    
    @IBAction func tappedBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        self.auth?.createUser(withEmail: email, password: password, completion: { (result, error)  in
            if error != nil {
                print("deu falaha")
            } else {
                print("sucesso")
            }
        })
    }
    
    func bottomView() {
        backGroundView.layer.cornerRadius = 50
        backGroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        backGroundView.layer.borderWidth = 1.5
        backGroundView.layer.borderColor = UIColor.black.cgColor
    }
    
    func disabledButton() {
        if emailTextField.text == "" || birthdayTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "" || nicknameTextField.text == "" {
            registerButton.isEnabled = false
            registerButton.backgroundColor = UIColor(red: 92/255, green: 94/255, blue: 100/255, alpha: 1.0)
        } else {
            registerButton.isEnabled = true
            registerButton.backgroundColor = UIColor(red: 29/255, green: 44/255, blue: 94/255, alpha: 1.0)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if (textField == self.emailTextField) {
            self.birthdayTextField.becomeFirstResponder()
        }
        else if (textField == self.birthdayTextField) {
            self.passwordTextField.becomeFirstResponder()
            
        } else if (textField == self.passwordTextField) {
            self.confirmPasswordTextField.becomeFirstResponder()
        }
        else if (textField == self.confirmPasswordTextField) {
            self.nicknameTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        disabledButton()
    }
    
    func cornerRadius() {
        registerButton.layer.cornerRadius = 17
    }
}
