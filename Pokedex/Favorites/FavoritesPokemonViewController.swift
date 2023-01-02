//
//  FavoritesPokemonViewController.swift
//  Pokedex
//
//  Created by Gabriel on 31/12/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import RealmSwift

class FavoritesPokemonViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let fireStore = Firestore.firestore()
    
    let user = Auth.auth().currentUser
    let service = PokemonService()
    var pokemon: [Pokemon] = []
    var alert: Alert?
    var pokemonNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert = Alert(controller: self)
        getPokemonResquest()
        configCollectionView()
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
    }
    
    func getPokemonResquest() {
        print(pokemonNames)
        for name in pokemonNames {
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
}

extension FavoritesPokemonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.identifier, for: indexPath) as? FavoritesCollectionViewCell
        cell?.backgroundColor = .clear
        cell?.setupCell(pokemon: pokemon[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "pokemonSelected", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "pokemon")
        navigationController?.pushViewController(viewcontroler, animated: true)
    }
}

extension FavoritesPokemonViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.size.width / 2.1 - 10
        return CGSize(width: size, height: size)
    }
}

