//
//  ViewController.swift
//  Pokedex
//
//  Created by Gabriel on 03/09/22.
//

import UIKit

class MyTabBarConstroller: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configTabBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 110
        tabBar.frame.origin.y = view.frame.height - 110
    }

    func configTabBar() {
        tabBar.layer.cornerRadius = 40
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tabBar.layer.borderWidth = 2.5
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.clipsToBounds = true
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        favoritesCollectionView.register(favoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: favoritesCollectionViewCell.identifier)
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        cornerRadiusView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        favoritesCollectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoritesCollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width - 20, height: 120)
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
        
        profileButton.backgroundColor = UIColor.white
        profileButton.layer.shadowColor = UIColor.black.cgColor
        profileButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        profileButton.layer.shadowOpacity = 1.0
        profileButton.layer.shadowRadius = 1
        profileButton.layer.masksToBounds = false
        profileButton.layer.cornerRadius = 25
    }
}

