//
//  CadastroViewController.swift
//  Pokedex
//
//  Created by Gabriel on 18/09/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

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
    var alert: Alert?
    
    let fireStore = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    var eyeClicked = false
    let imageEye = UIImageView()
    
    var eyeClicked2 = false
    let imageEye2 = UIImageView()
    
    var datePicker = UIDatePicker()
    var isPasswordEqual = false
    
    var equalPasswords = false
    var isEmptyTextField = true
    
    let user = Auth.auth().currentUser
    
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
        alert = Alert(controller: self)
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
        navigationController?.pushViewController(login, animated: true)
        let email: String = emailTextField.text ?? ""
        let password: String = passwordTextField.text ?? ""
        let birthday: String = birthdayTextField.text ?? ""
        let nickname: String = nicknameTextField.text ?? ""
        
        self.auth?.createUser(withEmail: email, password: password, completion: { (result, error)  in
            if error != nil {
                self.alert?.configAlert(title: "Ops", message: "Tivemos um erro ao criar a sua conta. Tente novamente!", secondButton: false)
            } else {
                self.alert?.configAlert(title: "Parabéns!!!", message: "Cadastro realizado com sucesso !!!", secondButton: false)
                self.saveUserData(email: email, birthday: birthday, nickname: nickname, id: result?.user.uid ?? "")
            }
        })
    }
    
    func saveUserData(email: String, birthday: String, nickname: String, id: String) {
        let dataPath = "user/\(id)"
        print("USER \(user?.uid ?? "")")
        let docRef = fireStore.document(dataPath)
        docRef.setData([
            "email": email,
            "birthday": birthday,
            "nickname": nickname
        ])
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
    
    func enableButton() {
        if passwordTextField.isFirstResponder || confirmPasswordTextField.isFirstResponder {
            if passwordTextField.text == confirmPasswordTextField.text {
                equalPasswords = true
                passwordTextField.layer.borderWidth = 0
                confirmPasswordTextField.layer.borderWidth = 0
            } else {
                equalPasswords = false
                passwordTextField.layer.borderColor = UIColor.red.cgColor
                passwordTextField.layer.borderWidth = 1
                confirmPasswordTextField.layer.borderWidth = 1
                confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
            }
        }
        
        if emailTextField.text == "" || birthdayTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == "" || nicknameTextField.text == "" {
            isEmptyTextField = true
        } else {
            isEmptyTextField = false
        }
        if equalPasswords == true && isEmptyTextField == false {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        enableButton()
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
