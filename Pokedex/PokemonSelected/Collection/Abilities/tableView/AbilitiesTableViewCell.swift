//
//  AbilitiesTableViewCell.swift
//  Pokedex
//
//  Created by Gabriel on 17/09/22.
//

import UIKit

class AbilitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var abilityLabel: NSLayoutConstraint!
    
    static let identifier: String = "AbilitiesTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
