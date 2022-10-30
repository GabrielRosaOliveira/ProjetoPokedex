//
//  CollectionViewController.swift
//  PokedexHome
//
//  Created by Gabriel on 03/09/22.
//

import UIKit

class CollectionViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var profileButton: UIButton!
    
    
    struct Pokedex {
        let nome: String
        let imageName: String
    }
    
    let data: [Pokedex] = [ Pokedex(nome: "Charmander", imageName: "imagem1"),
                            Pokedex(nome: "Lapras", imageName: "imagem2"),
                            Pokedex(nome: "Morcego", imageName: "imagem3"),
                            Pokedex(nome: "Bulbasaur", imageName: "imagem4"),
                            Pokedex(nome: "Pikachu", imageName: "imagem5"),
                            Pokedex(nome: "Charmander", imageName: "imagem1"),
                            Pokedex(nome: "Lapras", imageName: "imagem2"),
                            Pokedex(nome: "Morcego", imageName: "imagem3"),
                            Pokedex(nome: "Bulbasaur", imageName: "imagem4"),
                            Pokedex(nome: "Pikachu", imageName: "imagem5"),
                            Pokedex(nome: "Charmander", imageName: "imagem1"),
                            Pokedex(nome: "Lapras", imageName: "imagem2"),
                            Pokedex(nome: "Morcego", imageName: "imagem3"),
                            Pokedex(nome: "Bulbasaur", imageName: "imagem4"),
                            Pokedex(nome: "Pikachu", imageName: "imagem5"),
                            Pokedex(nome: "Charmander", imageName: "imagem1"),
                            Pokedex(nome: "Lapras", imageName: "imagem2"),
                            Pokedex(nome: "Morcego", imageName: "imagem3"),
                            Pokedex(nome: "Bulbasaur", imageName: "imagem4"),
                            Pokedex(nome: "Pikachu", imageName: "imagem5")]
    
    var filterPokemon: [Pokedex] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterPokemon = data
        configCollectionView()
        profileButton.layer.cornerRadius = 25
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        collectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    @IBAction func tappedProfileButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "profileStoryboard", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "profile")
        navigationController?.pushViewController(viewcontroler, animated: true)
        
    }
    
    
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if filterPokemon[indexPath.row].nome != "" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell
            cell?.label?.text = self.filterPokemon[indexPath.row].nome
            
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
            cell?.label.text = data[indexPath.row - 1].nome
            cell?.iconImageView.image = UIImage(named: data[indexPath.row].imageName)
            cell?.backgroundColor = .clear
            return cell ?? UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 40, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "pokemonSelected", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "pokemon")
        navigationController?.pushViewController(viewcontroler, animated: true)
    }
}

extension CollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filterPokemon = []
        if searchText.isEmpty {
            self.filterPokemon = self.data
        } else {
            for value in data {
                if value.nome.uppercased().contains(searchText.uppercased()) {
                    self.filterPokemon.append(value)
                }
            }
        }
        collectionView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
