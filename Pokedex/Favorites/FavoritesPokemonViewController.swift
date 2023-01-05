//
//  FavoritesPokemonViewController.swift
//  Pokedex
//
//  Created by Gabriel on 31/12/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FavoritesPokemonViewController: UIViewController {

    @IBOutlet var gradientView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    
    let fireStore = Firestore.firestore()
    let user = Auth.auth().currentUser
    let service = PokemonService()
    var pokemon: [Pokemon] = []
    var alert: Alert?
    var pokemonNames: [String] = []
    var pokemons: [Favorites] = []
    var favorites: [String] = []
    var userHasFavoritesYet = true
    var isError = false
    let gradient = CAGradientLayer()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        setGradient()
        configCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pokemon = []
        favorites = []
        userHasFavoritesYet = true
        getFavoritesPokemon()
        startLoading()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = gradientView.bounds
    }
    
    //MARK: - Metodos
    func setGradient() {
        gradient.colors = [ UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor,
                            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradient.shouldRasterize = true
        
        gradientView.layer.addSublayer(gradient)
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
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        collectionView.register(EmptyCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier)
        collectionView.register(ErrorCollectionViewCell.nib(), forCellWithReuseIdentifier: ErrorCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
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
        fireStore.collection(FavoritesTexts.firebaseCollection.rawValue).order(by: "pokemon", descending: true).getDocuments { snapshot, error in
            if error == nil {
                if let snapshot {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.pokemons = snapshot.documents.map({ document in
                            return Favorites(pokemon: document[FavoritesTexts.pokemonDocument.rawValue] as? [String] ?? [],
                                             email: document[FavoritesTexts.emailDocument.rawValue] as? String ?? ""
                            )
                        })
                        self.test(index: self.getIndex(email: self.user?.email ?? ""))
                        self.getPokemonResquest()
                        self.collectionView.reloadData()
                        self.stopLoading()
                    }
                }
            } else {
                self.alert?.configAlert(title: AlertTexts.errorTitle.rawValue, message: AlertTexts.errorMessage.rawValue, secondButton: false)
            }
        }
    }
    
    func getPokemonResquest() {
        for name in favorites {
            service.getPokemons(pokemon: name) { result, failure in
                if let result {
                    self.pokemon.append(result)
                } else {
                    self.alert?.configAlert(title: AlertTexts.errorTitle.rawValue, message: AlertTexts.errorMessage.rawValue, secondButton: false)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func disableCollectionInteraction() {
        if  favorites.count == 0 {
            collectionView.isUserInteractionEnabled = false
        } else {
            collectionView.isUserInteractionEnabled = true
        }
    }
}

extension FavoritesPokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favorites.count == 0 || isError {
            return 1
        } else {
            return pokemon.count
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
        
        if favorites.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: indexPath) as? EmptyCollectionViewCell
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.identifier, for: indexPath) as? FavoritesCollectionViewCell
            cell?.backgroundColor = .clear
            cell?.setupCell(pokemon: pokemon[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: FavoritesTexts.pokemonStoryboard.rawValue, bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: FavoritesTexts.pokemonDocument.rawValue) as? PokemonSelectedVc
        viewcontroler?.pokemonName = pokemon[indexPath.row].name
        viewcontroler?.isFavorite = true
        navigationController?.pushViewController(viewcontroler ?? UIViewController(), animated: true)
    }
}

extension FavoritesPokemonViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isError {
            return CGSize(width: view.frame.size.width - 30, height: 300)
        }
        
        let size = view.frame.size.width / 2.1 - 10
        return CGSize(width: size, height: size)
    }
}

extension FavoritesPokemonViewController: ErrorCollectionViewCellProtocol {
    func actionTryAgainButton() {
        pokemon = []
        favorites = []
        getFavoritesPokemon()
        getPokemonResquest()
        isError = false
        startLoading()
    }
}
