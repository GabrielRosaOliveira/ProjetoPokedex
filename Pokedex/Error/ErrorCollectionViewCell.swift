//
//  ErrorCollectionViewCell.swift
//  Pokedex
//
//  Created by Gabriel on 03/01/23.
//

import UIKit

protocol ErrorCollectionViewCellProtocol: AnyObject {
    func actionTryAgainButton()
}

class ErrorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var pikachuBadButton: UIImageView!
    @IBOutlet weak var backGroundView: UIView!
    
    static let identifier: String = "ErrorCollectionViewCell"
    weak var delegate: ErrorCollectionViewCellProtocol?
    
    func delegate(delegate: ErrorCollectionViewCellProtocol?) {
        self.delegate = delegate
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configLayout()
    }
    
    func configLayout() {
        pikachuBadButton.image = UIImage(named: "pikachuBad")
        tryAgainButton.layer.cornerRadius = 10
        tryAgainButton.layer.borderColor = UIColor.black.cgColor
        tryAgainButton.layer.borderWidth = 1
    }

    
    @IBAction func tappedTryAgainButton(_ sender: UIButton) {
        delegate?.actionTryAgainButton()
    }
    
    
}
