//
//  ViewController.swift
//  Pokedex
//
//  Created by Gabriel on 03/09/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var favoritesView: UIView!
    
    @IBOutlet weak var favoritesLabel: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    struct PokedexFavorites {
        let name: String
        let imageFavorite: String
    }
    
    let data: [PokedexFavorites] = [PokedexFavorites(name: "Lapras", imageFavorite: "laprasfavo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadiusView()
    }

    func cornerRadiusView() {
        favoritesView.layer.cornerRadius = 40
        favoritesView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        favoritesView.layer.borderWidth = 2.0
        favoritesView.layer.borderColor = UIColor.black.cgColor
        
        favoritesLabel.layer.shadowRadius = 3.5
        favoritesLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        favoritesLabel.layer.shadowOpacity = 1.0
        favoritesLabel.layer.masksToBounds = false
        favoritesLabel.layer.shadowColor = UIColor.black.cgColor
        
//        profileButton.layer.cornerRadius = 25
//        profileButton.layer.borderWidth = 1.3
//        profileButton.layer.borderColor = UIColor.black.cgColor
//        profileButton.layer.shadowRadius = 6
//        profileButton.layer.shadowOpacity = 1.0
//        profileButton.layer.masksToBounds = false
//        profileButton.layer.shadowColor = UIColor.black.cgColor
//        profileButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        profileButton.backgroundColor = UIColor.white
        profileButton.layer.shadowColor = UIColor.black.cgColor
        profileButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        profileButton.layer.shadowOpacity = 1.0
        profileButton.layer.shadowRadius = 1
        profileButton.layer.masksToBounds = false
        profileButton.layer.cornerRadius = 25
    }

}

