//
//  pokemonSelectedVc.swift
//  Pokedex
//
//  Created by Gabriel on 15/09/22.
//

import UIKit

class PokemonSelectedVc: UIViewController {
    
    @IBOutlet weak var telaTopView: UIView!
    @IBOutlet weak var TelaBottomView: UIView!
    
    @IBOutlet weak var infoCollectionView: UICollectionView!
    
    let gradient = CAGradientLayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inferiorBottoView()
        self.setGradient()
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
        
        infoCollectionView.register(SobreCollectionViewCell.nib(), forCellWithReuseIdentifier: SobreCollectionViewCell.identifier)
        
        infoCollectionView.register(AtributosCollectionViewCell.nib(), forCellWithReuseIdentifier: AtributosCollectionViewCell.identifier)
        
        infoCollectionView.register(HabilidadesCollectionViewCell.nib(), forCellWithReuseIdentifier: HabilidadesCollectionViewCell.identifier)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradient.frame = telaTopView.bounds
    
    }

    func setGradient() {
        gradient.colors = [ UIColor(red: 173/255, green: 236/255, blue: 150/255, alpha: 1.0).cgColor,
                            UIColor(red: 203/255, green: 144/255, blue: 197/255, alpha: 1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradient.shouldRasterize = true
       
        telaTopView.layer.addSublayer(gradient)
    }
    
    func inferiorBottoView() {
    
        TelaBottomView.layer.cornerRadius = 25
        TelaBottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        TelaBottomView.layer.borderWidth = 2.0
        TelaBottomView.layer.borderColor = UIColor.black.cgColor
    }
    
}

extension PokemonSelectedVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SobreCollectionViewCell.identifier, for: indexPath) as? SobreCollectionViewCell
            return cell ?? UICollectionViewCell()
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabilidadesCollectionViewCell.identifier, for: indexPath) as? HabilidadesCollectionViewCell
            return cell ?? UICollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AtributosCollectionViewCell.identifier, for: indexPath) as? AtributosCollectionViewCell
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: view.frame.size.width , height: 182)
        } else if indexPath.item == 1 {
            return CGSize(width: view.frame.size.width , height: 161)
        } else {
            return CGSize(width: view.frame.size.width , height: 150)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}


