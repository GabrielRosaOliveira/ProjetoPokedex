//
//  CadastroViewController.swift
//  Pokedex
//
//  Created by Gabriel on 18/09/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
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
    
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView()
        configButton()
        emailTextField.delegate = self
        birthdayTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        nicknameTextField.delegate = self
        registerButton.isEnabled = false
        
        cornerRadius()
        self.auth = Auth.auth()
        eyeMagic()
        eyeMagic2()
    }
    
    @objc func buttonCancel() {
        birthdayTextField.resignFirstResponder()
    }
    
    @objc func buttonOK() {
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "dd/MM/yyyy"
        birthdayTextField.text = dateFormatted.string(from: datePicker.date as Date)
        buttonCancel()
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
        
        let login = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        let vc = UIStoryboard(name: "profileStoryboard", bundle: nil).instantiateViewController(withIdentifier: "profile") as? ProfileViewController
        let gabriel = Register(email: emailTextField.text ?? "", birthday: birthdayTextField.text ?? "", password: passwordTextField.text ?? "", confirmPassword: confirmPasswordTextField.text ?? "", nickname: nicknameTextField.text ?? "")
        vc?.register = gabriel
        navigationController?.pushViewController(login, animated: true)
        
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        
        self.auth?.createUser(withEmail: email, password: password, completion: { (result, error)  in
            if error != nil {
                print("deu falaha")
            } else {
                let alertEditing = UIAlertController(title: "Parabéns!!!", message: "Cadastro realizado com sucesso !!!", preferredStyle: UIAlertController.Style.alert)
                alertEditing.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil))
                self.present(alertEditing,animated: true,completion: nil)
            }
        })
    }
    
    func bottomView() {
        backGroundView.layer.cornerRadius = 50
        backGroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        backGroundView.layer.borderWidth = 1.5
        backGroundView.layer.borderColor = UIColor.black.cgColor
    }
    
    func cornerRadius() {
        registerButton.layer.cornerRadius = 17
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.hasText {
            textField.layer.borderColor = UIColor.lightGray.cgColor
        }else {
            textField.layer.borderColor = UIColor.red.cgColor
        }
        
        if emailTextField.text == "" || birthdayTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "" || nicknameTextField.text == "" {
            registerButton.isEnabled = false
            
        } else {
            
            if passwordTextField.text == confirmPasswordTextField.text {
                passwordTextField.layer.borderColor = UIColor.green.cgColor
                passwordTextField.layer.borderWidth = 1
                confirmPasswordTextField.layer.borderWidth = 1
                confirmPasswordTextField.layer.borderColor = UIColor.green.cgColor
                registerButton.backgroundColor = UIColor(red: 29/255, green: 44/255, blue: 94/255, alpha: 1.0)
                registerButton.isEnabled = true
            } else {
                passwordTextField.layer.borderColor = UIColor.red.cgColor
                passwordTextField.layer.borderWidth = 1
                confirmPasswordTextField.layer.borderWidth = 1
                confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
                registerButton.isEnabled = false
            }
            
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == birthdayTextField) {
            return false
        } else {
            return true
        }
    }
}

extension RegisterViewController: UIPickerViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if birthdayTextField == textField {
            datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220))
            datePicker.datePickerMode = .date
            birthdayTextField.inputView = datePicker
            let toolbar = UIToolbar()
            toolbar.barStyle = .default
            toolbar.isTranslucent = true
            toolbar.sizeToFit()
            datePicker.preferredDatePickerStyle = .wheels
            let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(self.buttonOK))
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.buttonCancel))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolbar.setItems([cancelButton, spaceButton, okButton], animated: false)
            toolbar.isUserInteractionEnabled = true
            birthdayTextField.inputAccessoryView = toolbar
            
        }
    }
}
