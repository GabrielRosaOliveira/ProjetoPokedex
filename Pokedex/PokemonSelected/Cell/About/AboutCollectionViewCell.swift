//
//  SobreCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel on 15/09/22.
//

import UIKit

class AboutCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    static let identifier: String = PokemonSelectedTexts.aboutIdentifier.rawValue
    
    static func nib()-> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func setupCell(pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name.capitalized
        heightLabel.text = "\(pokemon.height)"
        weightLabel.text = "\(pokemon.weight)"
        abilitiesLabel.text = pokemon.abilities[0].ability.name
        
    }
    
}
