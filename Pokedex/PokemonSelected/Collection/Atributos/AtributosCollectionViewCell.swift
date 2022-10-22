//
//  AtributosCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel on 15/09/22.
//

import UIKit

class AtributosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var attacklabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    static let identifier: String = "AtributosCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configAttributes()
    }

    func configAttributes() {
        attacklabel.layer.shadowColor = UIColor.black.cgColor
        attacklabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        attacklabel.layer.shadowOpacity = 0.8
        attacklabel.layer.makeShadow(color: .gray, x: 0, y: 4, blur: 4,spread: 0)
        
        defenseLabel.layer.shadowColor = UIColor.black.cgColor
        defenseLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        defenseLabel.layer.shadowOpacity = 0.8
        defenseLabel.layer.makeShadow(color: .gray, x: 0, y: 4, blur: 4,spread: 0)
        
        speedLabel.layer.shadowColor = UIColor.black.cgColor
        speedLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        speedLabel.layer.shadowOpacity = 0.8
        speedLabel.layer.makeShadow(color: .gray, x: 0, y: 4, blur: 4,spread: 0)
    }
    
    
}
