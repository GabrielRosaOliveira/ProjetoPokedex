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
        contentView.backgroundColor = .clear
        backGroundView?.layer.cornerRadius = 25
        layer.masksToBounds = true
        backGroundView?.layer.borderColor = UIColor.black.cgColor
    }
}


