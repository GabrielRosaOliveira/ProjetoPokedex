//
//  ViewController.swift
//  Pokedex
//
//  Created by Gabriel on 03/09/22.
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var favoritesView: UIView!
    
    @IBOutlet weak var favoritesLabel: UILabel!
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    struct PokedexFavorites {
        let name: String
        let imageFavorite: String
    }
    
    let data: [PokedexFavorites] = [PokedexFavorites(name: "Lapras", imageFavorite: "laprasfavo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesCollectionView.register(FavoritesCollectionViewCell.nib(), forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        cornerRadiusView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.identifier, for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width - 20, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "pokemonSelected", bundle: nil)
        let viewcontroler = storyboard.instantiateViewController(withIdentifier: "pokemon")
        navigationController?.pushViewController(viewcontroler, animated: true)
    }
    
    func cornerRadiusView() {
        favoritesView.layer.cornerRadius = 40
        favoritesView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        favoritesView.layer.borderWidth = 2.0
        favoritesView.layer.borderColor = UIColor.black.cgColor
        favoritesView.clipsToBounds = true
        
        favoritesLabel.layer.shadowRadius = 3.5
        favoritesLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        favoritesLabel.layer.shadowOpacity = 1.0
        favoritesLabel.layer.masksToBounds = false
        favoritesLabel.layer.shadowColor = UIColor.black.cgColor
    }
}

