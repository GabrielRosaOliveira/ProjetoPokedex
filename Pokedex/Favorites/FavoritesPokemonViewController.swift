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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        configCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pokemon = []
        favorites = []
        userHasFavoritesYet = true
        getFavoritesPokemon()
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
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        collectionView.register(EmptyCollectionViewCell.nib(), forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier)
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
        fireStore.collection("favorites").order(by: "pokemon", descending: true).getDocuments { snapshot, error in
            if error == nil {
                if let snapshot {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.pokemons = snapshot.documents.map({ document in
                            return Favorites(pokemon: document["pokemon"] as? [String] ?? [],
                                             email: document["email"] as? String ?? ""
                            )
                        })
                        self.test(index: self.getIndex(email: self.user?.email ?? ""))
                        self.getPokemonResquest()
                        self.collectionView.reloadData()
                        self.stopLoading()
                    }
                }
            } else {
                self.alert?.configAlert(title: "Atenção", message: "Tivemos um problema no servidor, tente novamente.", secondButton: false)
            }
        }
    }
    
    
    func getPokemonResquest() {
        for name in favorites {
            service.getPokemons(pokemon: name) { result, failure in
                if let result {
                    self.pokemon.append(result)
                } else {
                    self.alert?.configAlert(title: "Ops", message: "Tivemos um problema no servidor, tente novamente!", secondButton: false)
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
        if favorites.count == 0 {
            return 1
        } else {
            return pokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        disableCollectionInteraction()
        
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
        let storyboard = UIStoryboard(name: "pokemonSelected", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "pokemon") as? PokemonSelectedVc
        viewcontroler?.pokemonName = pokemon[indexPath.row].name
        viewcontroler?.isFavorite = true
        navigationController?.pushViewController(viewcontroler ?? UIViewController(), animated: true)
    }
}

extension FavoritesPokemonViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.size.width / 2.1 - 10
        return CGSize(width: size, height: size)
    }
}
