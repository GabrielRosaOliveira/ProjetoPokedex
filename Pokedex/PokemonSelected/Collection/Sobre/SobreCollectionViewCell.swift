//
//  SobreCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel on 15/09/22.
//

import UIKit

class SobreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    static let identifier: String = "SobreCollectionViewCell"
    
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    
    
}
