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
    
    var pokemonNames: [String] = []
    let service = PokemonService()
    var pokemon: [Pokemon] = []
    let nameService = PokemonNameService()
    
    var isempty: Bool = false
    
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
        getPokemonResquest()
        collectionView.showsVerticalScrollIndicator = false
    }
    
    func setSearchTextField(text: String) {
        if text.isEmpty {
            self.filterPokemon = self.pokemon
            isempty = true
        } else {
            self.filterPokemon = self.pokemon.filter({
                let test = ($0.name).lowercased().contains(text.lowercased())
                print(test)
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
                    print("COLOCAR ALERT - DEU RUIM")
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.filterPokemon = self.pokemon
                }
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
            return filterPokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
        let size = view.frame.size.width / 2.1 - 10
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "pokemonSelected", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "pokemon") as? PokemonSelectedVc
        viewcontroler?.pokemonName = filterPokemon[indexPath.row].name
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
