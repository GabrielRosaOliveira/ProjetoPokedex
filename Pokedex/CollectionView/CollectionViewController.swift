//
//  CollectionViewController.swift
//  PokedexHome
//
//  Created by Gabriel on 03/09/22.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imageProfile: UIImageView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        imageProfile.layer.cornerRadius = 25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}


extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
        cell?.label.text = data[indexPath.item].nome
        cell?.iconImageView.image = UIImage(named: data[indexPath.item].imageName)
        cell?.backgroundColor = .clear
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 40, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(data[indexPath.item].nome)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "pokemonSelected", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "pokemon")
        navigationController?.pushViewController(viewcontroler, animated: true)
        }
    
    
}
