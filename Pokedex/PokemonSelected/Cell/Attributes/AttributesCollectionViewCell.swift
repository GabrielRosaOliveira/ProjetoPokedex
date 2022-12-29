//
//  AtributosCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel on 15/09/22.
//

import UIKit

class AttributesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var attacklabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var attributeTitleLabel: UILabel!
    
    @IBOutlet weak var attackProgress: UIProgressView!
    @IBOutlet weak var defenseProgress: UIProgressView!
    @IBOutlet weak var speedProgress: UIProgressView!
    
    
    
    static let identifier: String = "AttributesCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configAttributes()
    }
    
    func configAttributes() {
        attacklabel.layer.shadowColor = UIColor.black.cgColor
        attacklabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        attacklabel.layer.shadowOpacity = 0.8
        attacklabel.layer.makeShadow(color: .gray, x: 0, y: 4, blur: 4,spread: 0)
        
        defenseLabel.layer.shadowColor = UIColor.black.cgColor
        defenseLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        defenseLabel.layer.shadowOpacity = 0.8
        defenseLabel.layer.makeShadow(color: .gray, x: 0, y: 4, blur: 4,spread: 0)
        
        speedLabel.layer.shadowColor = UIColor.black.cgColor
        speedLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        speedLabel.layer.shadowOpacity = 0.8
        speedLabel.layer.makeShadow(color: .gray, x: 0, y: 4, blur: 4,spread: 0)
        
        attributeTitleLabel.layer.shadowColor = UIColor.gray.cgColor
        attributeTitleLabel.layer.shadowRadius = 1.5
        attributeTitleLabel.layer.shadowOpacity = 1.0
        attributeTitleLabel.layer.shadowOffset = CGSize(width: 0, height: 6.0)
    }
    
    func setupCell(pokemon: Pokemon) {
        attacklabel.text = "\(pokemon.stats[1].baseStat)"
        defenseLabel.text = "\(pokemon.stats[2].baseStat)"
        speedLabel.text = "\(pokemon.stats[5].baseStat)"
        attackProgress.progress = updateAttackProgressBar(pokemon: pokemon)
        defenseProgress.progress = updateDefenseProgressBar(pokemon: pokemon)
        speedProgress.progress = updateSpeedProgressBar(pokemon: pokemon)
    }
    
    func updateAttackProgressBar(pokemon: Pokemon) -> Float {
        return Float(pokemon.stats[1].baseStat) / 100
    }
    
    func updateDefenseProgressBar(pokemon: Pokemon) -> Float {
        return Float(pokemon.stats[2].baseStat) / 100
    }
    
    func updateSpeedProgressBar(pokemon: Pokemon) -> Float {
        return Float(pokemon.stats[5].baseStat) / 100
    }
    
}
