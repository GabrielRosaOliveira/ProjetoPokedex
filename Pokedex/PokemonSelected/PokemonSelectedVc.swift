//
//  pokemonSelectedVc.swift
//  Pokedex
//
//  Created by Gabriel on 15/09/22.
//

import UIKit
import AlamofireImage

class PokemonSelectedVc: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var namePokemonLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonTypeOneLabel: UILabel!
    @IBOutlet weak var pokemonTypeTwoLabel: UILabel!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    
    var pokemonName: String = ""
    var pokemon: Pokemon?
    let service = PokemonService()
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configBottomView()
        self.setGradient()
       configInfoCollectionView()
        infoCollectionView.register(AboutCollectionViewCell.nib(), forCellWithReuseIdentifier: AboutCollectionViewCell.identifier)
        infoCollectionView.register(AttributesCollectionViewCell.nib(), forCellWithReuseIdentifier: AttributesCollectionViewCell.identifier)
        infoCollectionView.register(AbilitiesCollectionViewCell.nib(), forCellWithReuseIdentifier: AbilitiesCollectionViewCell.identifier)
        getPokemonDetails()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = topView.bounds
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func getPokemonDetails() {
        service.getPokemons(pokemon: pokemonName) { result, failure in
            if let result {
                self.pokemon = result
            } else {
                print("COLOCAR ALERT - DEU RUIM")
            }
            DispatchQueue.main.async {
                self.populateView()
            }
        }
    }
    
    func populateView() {
        let url = URL(string: pokemon?.sprites.frontDefault ?? "") ?? URL(fileURLWithPath: "")
        pokemonImageView.af.setImage(withURL: url)
        
        namePokemonLabel.text = pokemon?.name
        pokemonNumberLabel.text = "Nº\(pokemon?.id ?? 0)"
        
        getTypes()
    }
    
    func getTypes() {
        if pokemon?.types.count == 1 {
            pokemonTypeOneLabel.text = pokemon?.types[0].type.name
        } else {
            pokemonTypeTwoLabel.text = pokemon?.types[1].type.name
            pokemonTypeOneLabel.text = pokemon?.types[0].type.name
        }
    }
    
    func configInfoCollectionView() {
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
    }
    
    func setGradient() {
        gradient.colors = [ UIColor(red: 173/255, green: 236/255, blue: 150/255, alpha: 1.0).cgColor,
                            UIColor(red: 203/255, green: 144/255, blue: 197/255, alpha: 1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradient.shouldRasterize = true
        
        topView.layer.addSublayer(gradient)
    }
    
    func configBottomView() {
        bottomView.layer.cornerRadius = 25
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        bottomView.layer.borderWidth = 2.0
        bottomView.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension PokemonSelectedVc: UICollectionViewDelegate {
    
}

extension PokemonSelectedVc: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutCollectionViewCell.identifier, for: indexPath) as? AboutCollectionViewCell
            return cell ?? UICollectionViewCell()
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AbilitiesCollectionViewCell.identifier, for: indexPath) as? AbilitiesCollectionViewCell
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttributesCollectionViewCell.identifier, for: indexPath) as? AttributesCollectionViewCell
            return cell ?? UICollectionViewCell()
        }
    }
}

extension PokemonSelectedVc: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: view.frame.size.width , height: 182)
        } else if indexPath.item == 1 {
            return CGSize(width: view.frame.size.width , height: 161)
        } else {
            return CGSize(width: view.frame.size.width , height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
