//
//  EmptyCollectionViewCell.swift
//  Pokedex
//
//  Created by Bruno Lopes on 03/01/23.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pokemonFaliedLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    
    static let identifier: String = "EmptyCollectionViewCell"
    
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
