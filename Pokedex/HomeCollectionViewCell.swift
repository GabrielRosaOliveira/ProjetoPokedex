//
//  HomeCollectionViewCell.swift
//  PokedexHome
//
//  Created by Gabriel on 03/09/22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    static let identifier: String = "HomeCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.layer.makeShadow(color: .black, x: 0, y: 2, blur: 4, spread: 0)
        iconImageView.layer.makeShadow(color: .black, x: 0, y: 2, blur: 4, spread: 0)
        contentView.backgroundColor = .clear
        backGroundView?.layer.cornerRadius = 25
        layer.masksToBounds = true
        backGroundView?.backgroundColor = .white
        backGroundView?.layer.borderWidth = 0.5
        backGroundView?.layer.borderColor = UIColor.black.cgColor
        backGroundView?.layer.makeShadow(color: .black, x: 0, y: 3, blur: 4, spread: 0)
    }
}

extension CALayer {

    func makeShadow(color: UIColor,
                    x: CGFloat = 0,
                    y: CGFloat = 0,
                    blur: CGFloat = 0,
                    spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = 1
        masksToBounds = false
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2
        if spread == 0 {
            shadowPath = nil
        }
        else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
