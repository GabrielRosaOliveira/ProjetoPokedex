//
//  CollectionViewController.swift
//  PokedexHome
//
//  Created by Gabriel on 03/09/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet var backGroundView: UIView!
    
    var pokemonNames: [String] = []
    let service = PokemonService()
    var pokemon: [Pokemon] = []
    let nameService = PokemonNameService()
    var isempty: Bool = false
    var alert: Alert?
    let fireStore = Firestore.firestore()
    var pokemons: [Favorites] = []
    var favorites: [String] = []
    let user = Auth.auth().currentUser
    var userHasFavoritesYet = true
    var isError: Bool = false
    
    var names: [String] = ["pikachu", "bulbasaur", "charmander", "squirtle", "pidgey", "meowth", "psyduck", "zubat", "rattata", "weedle", "vulpix", "growlithe", "poliwag", "abra", "machop", "tentacool", "slowpoke", "geodude", "seel", "grimer", "shellder", "krabby", "cubone", "voltorb", "tangela", "koffing", "horsea", "goldeen", "staryu", "ditto", "eevee", "porygon", "mew", "omanyte", "kabuto", "dratini", "metapod", "butterfree", "kakuna", "raticate", "sandslash", "nidorina", "nidorino", "jigglypuff", "gloom", "dugtrio", "weepinbell", "graveler", "haunter", "marowak", "starmie", "flareon"]
    
    var filterPokemon: [Pokemon] = []
    
    var pokemonList: Bool {
        return self.filterPokemon.count == 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        profileButton.layer.cornerRadius = 25
        searchTextField.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        alert = Alert(controller: self)
        backGroundView.backgroundColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0)
        collectionView.backgroundColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        pokemon = []
        favorites = []
        userHasFavoritesYet = true
        getFavoritesPokemon()
        getPokemonResquest()
        resetSearchTextFiels()
        startLoading()
    }
    
    func startLoading() {
        spinner.startAnimating()
        spinner.isHidden = false
        loadingView.isHidden = false
    }
    
    func stopLoading() {
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingView.isHidden = true
    }
    
    func resetSearchTextFiels() {
        searchTextField.text = ""
    }
    
    func setSearchTextField(text: String) {
        if text.isEmpty {
            self.filterPokemon = self.pokemon
            isempty = true
        } else {
            self.filterPokemon = self.pokemon.filter({
                let test = ($0.name).lowercased().contains(text.lowercased())
                return test
            })
            isempty = false
        }
    }
    
    func getPokemonResquest() {
        for name in names {
            service.getPokemons(pokemon: name) { result, failure in
                if let result {
                    self.pokemon.append(result)
                } else {
                    self.isError = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.collectionView.reloadData()
                    self.filterPokemon = self.pokemon
                    self.stopLoading()
                }
            }
        }
    }
    
    func test(index: Int) {
        if userHasFavoritesYet == true {
            for pokemon in pokemons[index].pokemon {
                favorites.append(pokemon)
            }
        }
    }
    
    func getIndex(email: String) -> Int {
        let index = pokemons.firstIndex { $0.email == email }
        
        if index == nil {
            userHasFavoritesYet = false
        }
        return index ?? 1
    }
    
    func getFavoritesPokemon() {
        fireStore.collection(HomeTexts.firebaseCollection.rawValue).getDocuments { snapshot, error in
            if error == nil {
                if let snapshot {
                    DispatchQueue.main.async {
                        self.pokemons = snapshot.documents.map({ document in
                            return Favorites(pokemon: document[HomeTexts.pokemonDocument.rawValue] as? [String] ?? [],
                                             email: document[HomeTexts.emailDocument.rawValue] as? String ?? ""
                            )
                        })
                        self.test(index: self.getIndex(email: self.user?.email ?? ""))
                    }
                }
            } else {
                self.alert?.configAlert(title: AlertTexts.errorTitle.rawValue, message: AlertTexts.errorMessage.rawValue, secondButton: false)
            }
        }
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(SearchCollectionViewCell.nib(), forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.register(ErrorCollectionViewCell.nib(), forCellWithReuseIdentifier: ErrorCollectionViewCell.identifier)
    }
    
    func disableCollectionInteraction() {
        if  pokemonList {
            collectionView.isUserInteractionEnabled = false
        } else {
            collectionView.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func tappedProfileButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: HomeTexts.profileStoryBoard.rawValue, bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: HomeTexts.profileIdentifier.rawValue )
        navigationController?.pushViewController(viewcontroler, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pokemonList || isError {
            return 1
        } else {
            return filterPokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        disableCollectionInteraction()
        
        if isError {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorCollectionViewCell.identifier, for: indexPath) as? ErrorCollectionViewCell
            cell?.backgroundColor = .clear
            cell?.delegate(delegate: self)
            return cell ?? UICollectionViewCell()
        }
        
        if pokemonList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell
            cell?.backgroundColor = .clear
            return cell ?? UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
        cell?.setupCell(pokemon: filterPokemon[indexPath.row])
        cell?.backgroundColor = .clear
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isError {
            return CGSize(width: view.frame.size.width - 30, height: 300)
        }
        
        let size = view.frame.size.width / 2.1 - 10
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: HomeTexts.pokemonSelectedStoryboard.rawValue, bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: HomeTexts.pokemonSelectedIdentifier.rawValue) as? PokemonSelectedVc
        viewcontroler?.pokemonName = filterPokemon[indexPath.row].name
        
        if favorites.contains(filterPokemon[indexPath.row].name) {
            viewcontroler?.isFavorite = true
        }
        navigationController?.pushViewController(viewcontroler ?? UIViewController(), animated: true)
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let updatedtext = text.replacingCharacters(in: range, with: string)
            setSearchTextField(text: updatedtext)
            collectionView.reloadData()
        }
        return true
    }
}

extension HomeViewController: ErrorCollectionViewCellProtocol {
    func actionTryAgainButton() {
        getFavoritesPokemon()
        getPokemonResquest()
        isError = false
        startLoading()
    }
}
