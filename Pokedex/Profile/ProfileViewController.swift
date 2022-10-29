//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Gabriel on 19/09/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var editPasswordTextField: UITextField!
    
    @IBOutlet weak var exitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundView()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func delete2(_ sender: UIButton) {
        let alertDelete = UIAlertController(title: "Atenção", message: "Tem certeza que gostaria de excluir seu cadastro?", preferredStyle: UIAlertController.Style.alert)
        alertDelete.addAction(UIAlertAction(title: "Excluir", style: UIAlertAction.Style.destructive, handler: nil))
        alertDelete.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertDelete,animated: true,completion: nil)
    }
    
    @IBAction func exitButton(_ sender: UIButton) {
        
        let alertExit = UIAlertController(title: "Atenção", message: "Você quer mesmo sair?", preferredStyle: UIAlertController.Style.alert)
        alertExit.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.destructive, handler: nil))
        alertExit.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertExit,animated: true,completion: nil)
    }
    
    @IBAction func editingNickname(_ sender: UITextField) {
    
                if nicknameTextField.isEnabled{
                    let alertEditing = UIAlertController(title: "Atenção", message: "Você quer mesmo alterar seu apelido?", preferredStyle: UIAlertController.Style.alert)
                    alertEditing.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.destructive, handler: nil))
                    alertEditing.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alertEditing,animated: true,completion: nil)
                }
    }
    
    @IBAction func editBirthday(_ sender: UITextField) {
        
        
        
        if birthdayTextField.isEnabled{
            let alertEditing = UIAlertController(title: "Atenção", message: "Você quer mesmo alterar sua data de nascimento?", preferredStyle: UIAlertController.Style.alert)
            alertEditing.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.destructive, handler: nil))
            alertEditing.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alertEditing,animated: true,completion: nil)
        }
    }
    
    @IBAction func editEmailAddress(_ sender: UITextField) {
    
        if emailTextField.isEnabled{
            let alertEditing = UIAlertController(title: "Atenção", message: "Você quer mesmo alterar seu endereço de e-mail?", preferredStyle: UIAlertController.Style.alert)
            alertEditing.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.destructive, handler: nil))
            alertEditing.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alertEditing,animated: true,completion: nil)
        }
    }
    
    @IBAction func changePassword(_ sender: UITextField) {
        
        if editPasswordTextField.isEnabled{
            let alertEditing = UIAlertController(title: "Atenção", message: "Você quer mesmo alterar sua senha?", preferredStyle: UIAlertController.Style.alert)
            alertEditing.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.destructive, handler: nil))
            alertEditing.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alertEditing,animated: true,completion: nil)
        }
    }

    func configBackgroundView(){
        
        backgroundView.layer.cornerRadius = 50
        backgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        backgroundView.layer.borderWidth = 1.5
        backgroundView.layer.borderColor = UIColor.black.cgColor
        
        nicknameTextField.layer.cornerRadius = 10
        nicknameTextField.layer.borderWidth = 1.0
        nicknameTextField.layer.borderColor = UIColor.black.cgColor
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.backgroundColor = .clear
        
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.borderStyle = .roundedRect
        emailTextField.backgroundColor = .clear
        
        birthdayTextField.layer.cornerRadius = 10
        birthdayTextField.layer.borderWidth = 1.0
        birthdayTextField.layer.borderColor = UIColor.black.cgColor
        birthdayTextField.borderStyle = .roundedRect
        birthdayTextField.backgroundColor = .clear
        
        editPasswordTextField.layer.cornerRadius = 10
        editPasswordTextField.layer.borderWidth = 1.0
        editPasswordTextField.layer.borderColor = UIColor.black.cgColor
        editPasswordTextField.borderStyle = .roundedRect
        editPasswordTextField.backgroundColor = .clear
    
        exitButton.layer.cornerRadius = 10
    
    }

}
