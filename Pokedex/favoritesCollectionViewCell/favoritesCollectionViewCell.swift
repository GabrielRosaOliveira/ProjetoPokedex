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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialConfig()
    }
    
    func initialConfig() {
        cellBackgroundView.layer.cornerRadius = 60
        cellBackgroundView.layer.borderWidth = 1.5
        cellBackgroundView.layer.borderColor = UIColor.black.cgColor
        cellBackgroundView.layer.shadowColor = UIColor.black.cgColor
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cellBackgroundView.layer.shadowOpacity = 1.0
        cellBackgroundView.layer.shadowRadius = 1
        cellBackgroundView.layer.makeShadow(color: .gray, x: 0, y: 4, blur: 4, spread: 0)
        cellBackgroundView.clipsToBounds = true

        let gradient = CAGradientLayer()
        gradient.frame = cellBackgroundView.bounds
        gradient.colors = [UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1).cgColor, UIColor.white.cgColor]
        gradient.shouldRasterize = true
        
        cellBackgroundView.layer.insertSublayer(gradient, at: 0)
    }
}
