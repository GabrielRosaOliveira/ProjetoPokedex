//
//  CollectionViewController.swift
//  PokedexHome
//
//  Created by Gabriel on 03/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profileButton: UIButton!
    
    let service = PokemonService()
    var pokemon: Pokemon?
    var index: Int = 0
    let imageService = PokemonImageService()
    var pokemonDetail: Result?
    
    struct Pokedex {
        let name: String
        let imageName: String
    }
    
    var isempty: Bool = false
    
    let data: [Pokedex] = [ Pokedex(name: "Charmander", imageName: "imagem1"),
                            Pokedex(name: "Lapras", imageName: "imagem2"),
                            Pokedex(name: "Morcego", imageName: "imagem3"),
                            Pokedex(name: "Bulbasaur", imageName: "imagem4"),
                            Pokedex(name: "Pikachu", imageName: "imagem5"),
                            Pokedex(name: "Charmander", imageName: "imagem1"),
                            Pokedex(name: "Lapras", imageName: "imagem2"),
                            Pokedex(name: "Morcego", imageName: "imagem3"),
                            Pokedex(name: "Bulbasaur", imageName: "imagem4"),
                            Pokedex(name: "Pikachu", imageName: "imagem5"),
                            Pokedex(name: "Charmander", imageName: "imagem1"),
                            Pokedex(name: "Lapras", imageName: "imagem2"),
                            Pokedex(name: "Morcego", imageName: "imagem3"),
                            Pokedex(name: "Bulbasaur", imageName: "imagem4"),
                            Pokedex(name: "Pikachu", imageName: "imagem5"),
                            Pokedex(name: "Charmander", imageName: "imagem1"),
                            Pokedex(name: "Lapras", imageName: "imagem2"),
                            Pokedex(name: "Morcego", imageName: "imagem3"),
                            Pokedex(name: "Bulbasaur", imageName: "imagem4"),
                            Pokedex(name: "Pikachu", imageName: "imagem5")]
    
    var filterPokemon: [Pokedex] = []
    
    var pokemonList: Bool {
        return self.filterPokemon.count == 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filterPokemon = data
        configCollectionView()
        profileButton.layer.cornerRadius = 25
        searchTextField.delegate = self
        getPokemonResquest()
        getImagePokemon()
    }
    
    func setSearchTextField(text: String) {
        if text.isEmpty {
            self.filterPokemon = self.data
            isempty = true
        } else {
            self.filterPokemon = self.data.filter({
                return ($0.name).lowercased().contains(text.lowercased())
            })
            isempty = false
        }
    }
    
    func getImagePokemon() {
        imageService.getPokemons(pokemon: pokemon?.results?[0].name ?? "") { result, failure in
            if let result {
                self.pokemonDetail = result
                print(self.pokemonDetail)
            } else {
                print("deu ruim")
            }
        }
    }
    
    func getPokemonResquest() {
        service.getPokemons() { result, failure in
            if let result {
                self.pokemon = result
//                print(self.pokemon)
            } else {
                print("deu ruim")
            }
        }
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(SearchCollectionViewCell.nib(), forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func tappedProfileButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "profileStoryboard", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "profile")
        navigationController?.pushViewController(viewcontroler, animated: true)
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pokemonList {
            return 1
        } else {
            return pokemon?.results?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if pokemonList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell
            cell?.backgroundColor = .clear
            return cell ?? UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
        cell?.namePokemonLabel.text = pokemon?.results?[indexPath.row].name
//        cell?.iconImageView.image = UIImage(named: filterPokemon[indexPath.row].imageName)
        cell?.backgroundColor = .clear
        index = indexPath.row
        return cell ?? UICollectionViewCell()
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
