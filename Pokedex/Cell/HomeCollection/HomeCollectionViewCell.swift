//
//  HomeCollectionViewCell.swift
//  PokedexHome
//
//  Created by Gabriel on 03/09/22.
//

import UIKit
import AlamofireImage

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var namePokemonLabel: UILabel!
    
    static let identifier: String = HomeTexts.homeIdentifier.rawValue
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configBackgroundView()
        backGroundView.backgroundColor = .white
        
    }
    
    func configBackgroundView() {
        namePokemonLabel.layer.makeShadow(color: .black, x: 0, y: 2, blur: 4, spread: 0)
        iconImageView.layer.makeShadow(color: .black, x: 0, y: 2, blur: 4, spread: 0)
        contentView.backgroundColor = .clear
        backGroundView?.layer.cornerRadius = 25
        layer.masksToBounds = true
        backGroundView?.backgroundColor = .white
        backGroundView?.layer.borderWidth = 0.5
        backGroundView?.layer.borderColor = UIColor.black.cgColor
        backGroundView?.layer.makeShadow(color: .black, x: 0, y: 3, blur: 4, spread: 0)
    }
    
    func setupCell(pokemon: Pokemon) {
        namePokemonLabel.text = pokemon.name.capitalized
        let url = URL(string: pokemon.sprites.other.home.frontDefault) ?? URL(fileURLWithPath: "")
        iconImageView.af.setImage(withURL: url)
    }
}

