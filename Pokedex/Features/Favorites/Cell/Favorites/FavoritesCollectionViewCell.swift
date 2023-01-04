//
//  FavoritesCollectionViewCell.swift
//  Pokedex
//
//  Created by Felipe Almeida on 07/09/22.
//

import UIKit
import AlamofireImage

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var pokemonImageView: UIImageView!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var cellBackgroundView: UIView!
    
    static let identifier = FavoritesTexts.favoritesIdentifier.rawValue
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialConfig()
        configBackgroundView()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        gradient.frame = cellBackgroundView.bounds
    }
    
    func configBackgroundView() {
        pokemonNameLabel.layer.makeShadow(color: .black, x: 0, y: 2, blur: 4, spread: 0)
        pokemonImageView.layer.makeShadow(color: .black, x: 0, y: 2, blur: 4, spread: 0)
        contentView.backgroundColor = .clear
        cellBackgroundView?.layer.cornerRadius = 25
        layer.masksToBounds = true
        cellBackgroundView?.backgroundColor = .white
        cellBackgroundView?.layer.borderWidth = 0.5
        cellBackgroundView?.layer.borderColor = UIColor.black.cgColor
        cellBackgroundView?.layer.makeShadow(color: .black, x: 0, y: 3, blur: 4, spread: 0)
    }
    
    func initialConfig() {
        cellBackgroundView.layer.cornerRadius = 50
        cellBackgroundView.layer.borderWidth = 1.5
        cellBackgroundView.layer.borderColor = UIColor.black.cgColor
        
        contentView.backgroundColor = .clear
        layer.masksToBounds = false
        cellBackgroundView.layer.borderColor = UIColor.black.cgColor
        cellBackgroundView.clipsToBounds = true
    }
    
    func setGradient() {
        gradient.colors = [UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1).cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradient.shouldRasterize = true
        gradient.frame = cellBackgroundView.bounds
        
        cellBackgroundView.layer.addSublayer(gradient)
    }
    
    func setupCell(pokemon: Pokemon) {
        let url = URL(string: pokemon.sprites.frontDefault) ?? URL(fileURLWithPath: "")
        pokemonImageView.af.setImage(withURL: url)
        pokemonNameLabel.text = pokemon.name.capitalized
    }
}
