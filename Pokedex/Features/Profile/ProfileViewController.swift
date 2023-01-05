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
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var exitButton: UIButton!
    
    var alert: Alert?
    let fireStore = Firestore.firestore()
    var userData: [Register] = []
    var userId: String = ""
    let user = Auth.auth().currentUser
    var isEditingProfile: Bool = true
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        alert = Alert(controller: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        getUserData()
    }
    
    //MARK: - Actions
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedEditButton(_ sender: UIButton) {
        updateUserData()
    }
    
    @IBAction func tappedDeleteAccountButton(_ sender: UIButton) {
        alert?.configAlert(title: AlertTexts.errorTitle.rawValue, message: AlertTexts.TitleDeletedAccount.rawValue, secondButton: true, completion: {
            self.user?.delete()
            let storyboard = UIStoryboard(name: ProfileTexts.loginStoryboard.rawValue, bundle: nil)
            let viewcontroler = storyboard.instantiateViewController(withIdentifier: ProfileTexts.loginIdentifier.rawValue)
            self.navigationController?.pushViewController(viewcontroler, animated: true)
        })
    }
    
    @IBAction func tappedExitAccountButton(_ sender: UIButton) {
        alert?.configAlert(title: AlertTexts.errorTitle.rawValue, message: AlertTexts.titleExitAccount.rawValue, secondButton: true, completion: {
            let storyboard = UIStoryboard(name: ProfileTexts.loginStoryboard.rawValue, bundle: nil)
            let viewcontroler = storyboard.instantiateViewController(withIdentifier: ProfileTexts.loginIdentifier.rawValue)
            self.navigationController?.pushViewController(viewcontroler, animated: true)
        })
    }
    
    //MARK: - Firebase
    
    func getIndex(email: String) -> Int {
        let index = userData.firstIndex { $0.email == email } ?? 0
        return index
    }
    
    //    buscando dados do usuario no fireBase
    func getUserData() {
        fireStore.collection(ProfileTexts.userCollection.rawValue).getDocuments { snapshot, error in
            if error == nil {
                if let snapshot {
                    DispatchQueue.main.async {
                        self.userData = snapshot.documents.map({ document in
                            return Register(id: document.documentID,
                                            email: document[ProfileTexts.emailDocument.rawValue] as? String ?? "",
                                            birthday: document[ProfileTexts.birthdayDocument.rawValue] as? String ?? "",
                                            password: document[ProfileTexts.passwordDocument.rawValue] as? String ?? "",
                                            nickname: document[ProfileTexts.nicknameDocument.rawValue] as? String ?? "")
                            
                        })
                        self.populateUserData(index: self.getIndex(email: self.user?.email ?? ""))
                    }
                }
            } else {
                self.alert?.configAlert(title: AlertTexts.errorTitle.rawValue, message: AlertTexts.errorMessage.rawValue, secondButton: false)
            }
        }
    }
    
    func populateUserData(index: Int) {
        emailTextField.text = userData[index].email
        birthdayTextField.text = userData[index].birthday
        nicknameTextField.text = userData[index].nickname
        hellLabel.text = "Olá, \(userData[index].nickname.capitalized)!"
    }
    
    func updateDataFromFirebase() {
        let dataPath = "user/\(user?.uid ?? "")"
        let dockRef = fireStore.document(dataPath)
        dockRef.updateData([
            ProfileTexts.birthdayDocument.rawValue: birthdayTextField.text ?? "",
            ProfileTexts.nicknameDocument.rawValue: nicknameTextField.text ?? ""
        ])
    }
    
    func updateUserData() {
        if isEditingProfile {
            editButton.setTitle("Salvar", for: .normal)
            
            birthdayTextField.layer.cornerRadius = 5
            birthdayTextField.layer.borderWidth = 1.0
            birthdayTextField.layer.borderColor = UIColor.black.cgColor
            birthdayTextField.isUserInteractionEnabled = true
            birthdayTextField.borderStyle = .roundedRect
            
            nicknameTextField.layer.cornerRadius = 5
            nicknameTextField.layer.borderWidth = 1.0
            nicknameTextField.layer.borderColor = UIColor.black.cgColor
            nicknameTextField.isUserInteractionEnabled = true
            nicknameTextField.borderStyle = .roundedRect
            
            isEditingProfile = false
        } else {
            editButton.setTitle("Editar", for: .normal)
            initialConfig()
            isEditingProfile = true
            updateDataFromFirebase()
        }
    }
    
    func initialConfig(){
        backgroundView.layer.cornerRadius = 50
        backgroundView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        backgroundView.layer.borderWidth = 1.5
        backgroundView.layer.borderColor = UIColor.black.cgColor
        
        emailTextField.layer.borderWidth = 0
        emailTextField.borderStyle = .none
        emailTextField.backgroundColor = .clear
        emailTextField.isUserInteractionEnabled = false
        
        birthdayTextField.layer.borderWidth = 0
        birthdayTextField.borderStyle = .none
        birthdayTextField.backgroundColor = .clear
        birthdayTextField.isUserInteractionEnabled = false
        
        nicknameTextField.layer.borderWidth = 0
        nicknameTextField.borderStyle = .none
        nicknameTextField.backgroundColor = .clear
        nicknameTextField.isUserInteractionEnabled = false
        
        exitButton.layer.cornerRadius = 10
    }
}
