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
        //        bulbasaurLabel.layer.borderWidth = 2.0
        //        bulbasaurLabel.layer.borderColor = UIColor.black.cgColor
    }
    
}



