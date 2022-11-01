//
//  SearchCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel on 30/10/22.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pokemonFaliedLabel: UILabel!
    
    @IBOutlet weak var backGroundView: UIView!
    
    
    static let identifier: String = "SearchCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configoBackGroundView()
    }
    
    func setupCell(nameFalied: String) {
        pokemonFaliedLabel.text = nameFalied
    }

    func configoBackGroundView() {
        pokemonFaliedLabel.layer.makeShadow(color: .black, x: 0, y: 2, blur: 4, spread: 0)
        contentView.backgroundColor = .clear
        backGroundView?.layer.cornerRadius = 25
        layer.masksToBounds = true
        backGroundView?.backgroundColor = .white
        backGroundView?.layer.borderWidth = 0.5
        backGroundView?.layer.borderColor = UIColor.black.cgColor
//        backGroundView?.layer.makeShadow(color: .black, x: 0, y: 3, blur: 4, spread: 0)
        
    }
}

 
