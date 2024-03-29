//
//  pokemonSelectedVc.swift
//  Pokedex
//
//  Created by Gabriel on 15/09/22.
//

import UIKit
import AlamofireImage
import FirebaseFirestore
import FirebaseAuth

class PokemonSelectedVc: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var namePokemonLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonTypeOneLabel: UILabel!
    @IBOutlet weak var pokemonTypeTwoLabel: UILabel!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    @IBOutlet weak var typeTwoView: UIView!
    @IBOutlet weak var typeOneView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let user = Auth.auth().currentUser
    var pokemonName: String = ""
    var pokemon: [Pokemon] = []
    let service = PokemonService()
    let gradient = CAGradientLayer()
    var isEmpty: Bool = true
    var alert: Alert?
    var type: PokemomTypes?
    var isFavoriteFulfilled = true
    var favoritesPokemon: [String] = []
    let fireStore = Firestore.firestore()
    var isFavorite: Bool = false
    var imageService = PokemonNameService()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configBottomView()
        self.setGradient()
        configInfoCollectionView()
        namePokemonLabel.layer.makeShadow(color: .black, x: 0, y: 2, blur: 4, spread: 0)
        alert = Alert(controller: self)
        creatCollection()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = topView.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        getPokemonDetails()
        favoriteButton(isFavorite)
    }
    
    //MARK: - Actions
    @IBAction func tappedStarButton(_ sender: UIButton) {
        if isFavoriteFulfilled {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal) // FAVORITANDO
            isFavoriteFulfilled = false
            favoriteButton.configuration?.baseForegroundColor = UIColor.yellow
            saveFovritesPokemons(pokemon: namePokemonLabel.text?.lowercased() ?? "")
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            isFavoriteFulfilled = true
            removePokemonFromFavorites(pokemon: namePokemonLabel.text?.lowercased() ?? "")
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Metodos
    func favoriteButton(_ isFavorite: Bool) {
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            favoriteButton.configuration?.baseForegroundColor = UIColor.yellow
            isFavoriteFulfilled = false
        }
    }
    
    func creatCollection() {
        let dataPath = "favorites/\(user?.email ?? "")"
        let dockRef = fireStore.document(dataPath)
        dockRef.getDocument { document, error in
            let a = document?.exists
            if a == false {
                dockRef.setData([
                    PokemonSelectedTexts.pokemonDocument.rawValue: [],
                    PokemonSelectedTexts.emailDocument.rawValue: self.user?.email ?? ""
                ])
            }
        }
    }
    
    func saveFovritesPokemons(pokemon: String) {
        let dataPath = "favorites/\(user?.email ?? "")"
        let dockRef = fireStore.document(dataPath)
        dockRef.updateData([PokemonSelectedTexts.pokemonDocument.rawValue: FieldValue.arrayUnion([pokemon])])
    }
    
    func removePokemonFromFavorites(pokemon: String) {
        fireStore.collection(PokemonSelectedTexts.favoritesCollection.rawValue).document(user?.email ?? "").updateData([PokemonSelectedTexts.pokemonDocument.rawValue: FieldValue.arrayRemove([pokemon])])
    }
    
    func getPokemonDetails() {
        service.getPokemons(pokemon: pokemonName) { result, failure in
            if let result {
                self.pokemon.append(result)
            } else {
                self.alert?.configAlert(title: AlertTexts.errorTitle.rawValue, message: AlertTexts.errorMessage.rawValue, secondButton: false)
            }
            DispatchQueue.main.async {
                self.isEmpty = false
                self.infoCollectionView.reloadData()
                self.populateView()
            }
        }
    }
    
    func getImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func populateView() {
        let url = URL(string: pokemon[0].sprites.other.home.frontDefault) ?? URL(fileURLWithPath: "")
        pokemonImageView.af.setImage(withURL: url)
        
        namePokemonLabel.text = pokemon[0].name.capitalized
        pokemonNumberLabel.text = "Nº \(pokemon[0].id)"
        getTypes()
        getTypeConstrainsts()
    }
    
    func getTypeConstrainsts() {
        if pokemon[0].types.count == 1 {
            typeOneView.isHidden = true
        }
    }
    
    func getColorTypes(type: String) -> UIColor {
        switch type {
        case "bug":
            return UIColor(red: 158/255, green: 197/255, blue: 61/255, alpha: 1.0)
        case "dark":
            return UIColor(red: 85/255, green: 84/255, blue: 100/255, alpha: 1.0)
        case "dragon":
            return UIColor(red: 0/255, green: 108/255, blue: 179/255, alpha: 1.0)
        case "electric":
            return UIColor(red: 253/255, green: 209/255, blue: 86/255, alpha: 1.0)
        case "fairy":
            return UIColor(red: 255/255, green: 204/255, blue: 240/255, alpha: 1.0)
        case "fighting":
            return UIColor(red: 227/255, green: 49/255, blue: 83/255, alpha: 1.0)
        case "fire":
            return UIColor(red: 255/255, green: 150/255, blue: 79/255, alpha: 1.0)
        case "flying":
            return UIColor(red: 138/255, green: 173/255, blue: 223/255, alpha: 1.0)
        case "ghost":
            return UIColor(red: 85/255, green: 104/255, blue: 182/255, alpha: 1.0)
        case "grass":
            return UIColor(red: 131/255, green: 220/255, blue: 168/255, alpha: 1.0)
        case "ground":
            return UIColor(red: 223/255, green: 116/255, blue: 77/255, alpha: 1.0)
        case "ice":
            return UIColor(red: 99/255, green: 210/255, blue: 198/255, alpha: 1.0)
        case "normal":
            return UIColor(red: 143/255, green: 149/255, blue: 150/255, alpha: 1.0)
        case "poison":
            return UIColor(red: 186/255, green: 87/255, blue: 196/255, alpha: 1.0)
        case "psychic":
            return UIColor(red: 255/255, green: 130/255, blue: 130/255, alpha: 1.0)
        case "rock":
            return UIColor(red: 202/255, green: 181/255, blue: 134/255, alpha: 1.0)
        case "steel":
            return UIColor(red: 53/255, green: 144/255, blue: 153/255, alpha: 1.0)
        case "water":
            return UIColor(red: 52/255, green: 156/255, blue: 211/255, alpha: 1.0)
        default:
            return UIColor(red: 52/255, green: 156/255, blue: 211/255, alpha: 1.0)
        }
    }
    
    func getTypes() {
        if pokemon[0].types.count == 1 {
            pokemonTypeTwoLabel.text = pokemon[0].types[0].type.name
            typeTwoView.backgroundColor = getColorTypes(type: pokemon[0].types[0].type.name)
        } else {
            pokemonTypeOneLabel.text = pokemon[0].types[1].type.name
            pokemonTypeTwoLabel.text = pokemon[0].types[0].type.name
            typeOneView.backgroundColor = getColorTypes(type: pokemon[0].types[1].type.name)
            typeTwoView.backgroundColor = getColorTypes(type: pokemon[0].types[0].type.name)
        }
    }
    
    func configInfoCollectionView() {
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
        infoCollectionView.register(AboutCollectionViewCell.nib(), forCellWithReuseIdentifier: AboutCollectionViewCell.identifier)
        infoCollectionView.register(AttributesCollectionViewCell.nib(), forCellWithReuseIdentifier: AttributesCollectionViewCell.identifier)
        infoCollectionView.register(SearchCollectionViewCell.nib(), forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    func setGradient() {
        gradient.colors = [ UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor,
                            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradient.shouldRasterize = true
        
        topView.layer.addSublayer(gradient)
    }
    
    func configBottomView() {
        bottomView.layer.cornerRadius = 25
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.layer.borderWidth = 2.0
        bottomView.layer.borderColor = UIColor.black.cgColor
    }
}

extension PokemonSelectedVc: UICollectionViewDelegate {
    
}

extension PokemonSelectedVc: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell
            return cell ?? UICollectionViewCell()
        }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutCollectionViewCell.identifier, for: indexPath) as? AboutCollectionViewCell
            cell?.setupCell(pokemon: self.pokemon[0])
            infoCollectionView.reloadData()
            return cell ?? UICollectionViewCell()
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttributesCollectionViewCell.identifier, for: indexPath) as? AttributesCollectionViewCell
            cell?.setupCell(pokemon: pokemon[0])
            infoCollectionView.reloadData()
            return cell ?? UICollectionViewCell()
        }
    }
}

extension PokemonSelectedVc: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: view.frame.size.width , height: 182)
        } else if indexPath.item == 1 {
            return CGSize(width: view.frame.size.width , height: 161)
        } else {
            return CGSize(width: view.frame.size.width , height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

