//
//  favoritesCollectionViewCell.swift
//  Pokedex
//
//  Created by Felipe Almeida on 07/09/22.
//

import UIKit

class favoritesCollectionViewCell: UICollectionViewCell {
    static let identifier = "favoritesCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    @IBOutlet var pokemonImageView: UIImageView!
    
    @IBOutlet var pokemonNameLabel: UILabel!
    
    @IBOutlet var pokemonNumberLabel: UILabel!
    
    @IBOutlet var cellBackgroundView: UIView!
    
    @IBOutlet var pokemonTypeImageView: UIImageView!
    
    @IBOutlet var shadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        initialConfig()
        shadowName()
        shadowNumber()
    }

    func shadowNumber() {
        pokemonNumberLabel.layer.shadowColor = UIColor.black.cgColor
        pokemonNumberLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        pokemonNumberLabel.layer.shadowOpacity = 0.8
        pokemonNumberLabel.layer.shadowRadius = 15
        pokemonNumberLabel.layer.makeShadow(color: .gray, x: 0, y: 4, blur: 4, spread: 0)
    }
    
    func shadowName() {
        pokemonNameLabel.layer.shadowColor = UIColor.black.cgColor
        pokemonNameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        pokemonNameLabel.layer.shadowOpacity = 0.8
        pokemonNameLabel.layer.shadowRadius = 15
        pokemonNameLabel.layer.makeShadow(color: .gray, x: 0, y: 4, blur: 4, spread: 0)
    }
    
    func initialConfig() {
        cellBackgroundView.layer.cornerRadius = 55
        cellBackgroundView.layer.borderWidth = 1.5
        cellBackgroundView.layer.borderColor = UIColor.black.cgColor

        contentView.backgroundColor = .clear
        layer.masksToBounds = true
        cellBackgroundView.backgroundColor = .white
        cellBackgroundView.layer.borderColor = UIColor.black.cgColor
        cellBackgroundView.clipsToBounds = true
        
        shadowView.clipsToBounds = true
        shadowView.layer.cornerRadius = 55
        shadowView.backgroundColor = .white
        shadowView.layer.makeShadow(color: .darkGray, x: 0, y: 5, blur: 3, spread: 0)
        
        let gradient = CAGradientLayer()
        gradient.frame = cellBackgroundView.bounds
        gradient.colors = [UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1).cgColor, UIColor.white.cgColor]
        gradient.shouldRasterize = true
        
        cellBackgroundView.layer.insertSublayer(gradient, at: 0)
    }
}
