//
//  ProfileViewController.swift
//  Pokedex
//
//  Created by Gabriel on 19/09/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var hellLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var editPasswordTextField: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    
    var alert: Alert?
    var register: Register?
    let fireStore = Firestore.firestore()
    var userData: [Register] = []
    var userId: String = ""
    let user = Auth.auth().currentUser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundView()
        alert = Alert(controller: self)
        
        emailTextField.text = register?.email
        birthdayTextField.text = register?.birthday
        nicknameTextField.text = register?.nickname
        editPasswordTextField.text = register?.password
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        getUserData()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func getIndex(email: String) -> Int {
        let index = userData.firstIndex { $0.email == email } ?? 0
        print(index)
        return index
    }
    
//    buscando dados do usuario no fireBase
    func getUserData() {
        fireStore.collection("user").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot {
                    DispatchQueue.main.async {
                        self.userData = snapshot.documents.map({ document in
                            print(self.user?.email)
                            return Register(id: document.documentID,
                                            email: document["email"] as? String ?? "",
                                            birthday: document["birthday"] as? String ?? "",
                                            password: document["password"] as? String ?? "",
                                            nickname: document["nickname"] as? String ?? "")
                           
                        })
                        self.populateUserData(index: self.getIndex(email: self.user?.email ?? ""))
                    }
                }
            } else {
                let alertEditing = UIAlertController(title: "Atenção", message: "Tivemos um problema no servidor, tente novamente.", preferredStyle: UIAlertController.Style.alert)
                alertEditing.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil))
                self.present(alertEditing,animated: true,completion: nil)
            }
            
        }
    }
    
    func populateUserData(index: Int) {
        
        emailTextField.text = userData[index].email
        birthdayTextField.text = userData[index].birthday
        editPasswordTextField.text = userData[index].password
        nicknameTextField.text = userData[index].nickname
        hellLabel.text = "Olá,\(userData[index].nickname)"
    }
    
    @IBAction func tappedExitAccountButton(_ sender: UIButton) {
        alert?.configAlert(title: "Atenção", message: "Você quer mesmo sair?", completion: {
            let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let viewcontroler = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.navigationController?.pushViewController(viewcontroler, animated: true)
        })
    }
    
    @IBAction func tappedEditingNicknameTextField(_ sender: UITextField) {
        if nicknameTextField.isEnabled{
            let alertEditing = UIAlertController(title: "Atenção", message: "Você quer mesmo alterar seu apelido?", preferredStyle: UIAlertController.Style.alert)
            alertEditing.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.destructive, handler: nil))
            alertEditing.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alertEditing,animated: true,completion: nil)
        }
    }
    
    @IBAction func tappedEditBirthdayTextField(_ sender: UITextField) {
        if birthdayTextField.isEnabled{
            let alertEditing = UIAlertController(title: "Atenção", message: "Você quer mesmo alterar sua data de nascimento?", preferredStyle: UIAlertController.Style.alert)
            alertEditing.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.destructive, handler: nil))
            alertEditing.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alertEditing,animated: true,completion: nil)
        }
    }
    
    @IBAction func tappedEditEmailAddressTextField(_ sender: UITextField) {
        if emailTextField.isEnabled{
            let alertEditing = UIAlertController(title: "Atenção", message: "Você quer mesmo alterar seu endereço de e-mail?", preferredStyle: UIAlertController.Style.alert)
            alertEditing.addAction(UIAlertAction(title: "Sim", style: UIAlertAction.Style.destructive, handler: nil))
            alertEditing.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alertEditing,animated: true,completion: nil)
        }
    }
    
    @IBAction func tappedChangePasswordTextField(_ sender: UITextField) {
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
