//
//  SobreCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel on 15/09/22.
//

import UIKit

class AboutCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    static let identifier: String = "AboutCollectionViewCell"
    
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLabel()
    }
    
    func configLabel() {
        titleLabel.layer.shadowColor = UIColor.gray.cgColor
        titleLabel.layer.shadowRadius = 1.5
        titleLabel.layer.shadowOpacity = 1.0
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 6.0)
    }
}