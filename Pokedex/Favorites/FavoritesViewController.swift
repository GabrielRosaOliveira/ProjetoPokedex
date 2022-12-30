//
//  ViewController.swift
//  Pokedex
//
//  Created by Gabriel on 03/09/22.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth


class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesView: UIView!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    let fireStore = Firestore.firestore()
    var favorites: [String] = []
    let user = Auth.auth().currentUser
    let service = PokemonService()
    var pokemon: [Pokemon] = []
    var alert: Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesCollectionView.register(FavoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        ConfigFavoritesCollectionView()
        cornerRadiusView()
        favoritesCollectionView.showsVerticalScrollIndicator = false
//        getFavoritesPokemon()
        alert = Alert(controller: self)
        makeRequest()
//            self.getPokemonResquest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func getFavoritesPokemon() {
        fireStore.collection("favorites").document(user?.email ?? "").getDocument { [weak self] snapshot, error in
            if error == nil {
                    guard let data = snapshot else { return }
                    let favorites = data["pokemon"] as? [String]
                    self?.favorites.append(contentsOf: favorites ?? [])
                
            } else {
                //               colocar alert
            }
        }

    }

    func makeRequest() {
        DispatchQueue.global().async {
            let dispathGroup = DispatchGroup()
            
            dispathGroup.enter()
            self.fireStore.collection("favorites").document(self.user?.email ?? "").getDocument { [weak self] snapshot, error in
                if error == nil {
                        guard let data = snapshot else { return }
                        let favorites = data["pokemon"] as? [String]
                        self?.favorites.append(contentsOf: favorites ?? [])
                    dispathGroup.leave()
                } else {
                    //               colocar alert
                }
            }
            dispathGroup.wait()
            
            dispathGroup.enter()
            for name in self.favorites {
                self.service.getPokemons(pokemon: name) { [weak self] result, failure in
                    if let result {
                        self?.pokemon.append(result)
                    } else {
                        self?.alert?.configAlert(title: "Ops", message: "Tivemos um problema no servidor, tente novamente!", secondButton: false)
                    }
                    
                        self?.favoritesCollectionView.reloadData()
                    
                }
            }
        }
    }

    func getPokemonResquest() {
        for name in favorites {
            service.getPokemons(pokemon: name) { [weak self] result, failure in
                if let result {
                    self?.pokemon.append(result)
                } else {
                    self?.alert?.configAlert(title: "Ops", message: "Tivemos um problema no servidor, tente novamente!", secondButton: false)
                }
                DispatchQueue.main.async {
                    self?.favoritesCollectionView.reloadData()
                }
            }
        }
    }
    
    func ConfigFavoritesCollectionView() {
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
    }
    
    func cornerRadiusView() {
        favoritesView.layer.cornerRadius = 40
        favoritesView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        favoritesView.layer.borderWidth = 2.0
        favoritesView.layer.borderColor = UIColor.black.cgColor
        favoritesView.clipsToBounds = true
        
        favoritesLabel.layer.shadowRadius = 3.5
        favoritesLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        favoritesLabel.layer.shadowOpacity = 1.0
        favoritesLabel.layer.masksToBounds = false
        favoritesLabel.layer.shadowColor = UIColor.black.cgColor
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    
}

extension FavoritesViewController: UICollectionViewDataSource {
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

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.size.width / 2.1 - 10
        return CGSize(width: size, height: size)
    }
}
