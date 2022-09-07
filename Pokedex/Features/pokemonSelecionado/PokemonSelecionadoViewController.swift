//
//  PokemonSelecionadoViewController.swift
//  Pokedex
//
//  Created by Felipe Almeida on 03/09/22.
//

import UIKit

class PokemonSelecionadoViewController: UIViewController {
    
    struct Teste {
        let nome: String
    }
    
    let resultado: [Teste] = [Teste(nome: "Gabriel")]

    @IBOutlet weak var telaTopView: UIView!
    @IBOutlet weak var TelaBottomView: UIView!
    
    @IBOutlet weak var typeSecondarySelectedLabel: UILabel!
    @IBOutlet weak var typeSelectedLabel: UILabel!
    
    @IBOutlet weak var pokemonSelectedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.superiorTopView()
        self.inferiorBottonView()
        configTypeSelectedCornerRadius()
        pokemonSelectedCollectionView.delegate = self
        pokemonSelectedCollectionView.dataSource = self
    }

    func superiorTopView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = telaTopView.bounds
        gradientLayer.colors = [ UIColor(red: 86/255, green: 239/255, blue: 119/255, alpha: 1.0).cgColor,
                                 UIColor(red: 203/255, green: 114/255, blue: 255/255, alpha: 1.0).cgColor]
        telaTopView.layer.addSublayer(gradientLayer)
    }
    
    func inferiorBottonView() {
        

        TelaBottomView.layer.cornerRadius = 25
        TelaBottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        TelaBottomView.layer.borderWidth = 2.0
        TelaBottomView.layer.borderColor = UIColor.black.cgColor
//        bulbasaurLabel.layer.borderWidth = 2.0
//        bulbasaurLabel.layer.borderColor = UIColor.black.cgColor
    }
    func configTypeSelectedCornerRadius() {
        typeSecondarySelectedLabel.layer.cornerRadius = 8
        typeSecondarySelectedLabel.layer.masksToBounds = true
        typeSelectedLabel.layer.cornerRadius = 8
        typeSelectedLabel.layer.masksToBounds = true
    }
}

extension PokemonSelecionadoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultado.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PokemonSelecionadoViewController
        return cell
    }
    
    


        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print(resultado[indexPath.item].nome)
        }
}

