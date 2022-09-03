//
//  PokemonSelecionadoViewController.swift
//  Pokedex
//
//  Created by Felipe Almeida on 03/09/22.
//

import UIKit

class PokemonSelecionadoViewController: UIViewController {

    @IBOutlet weak var telaTopView: UIView!
    @IBOutlet weak var TelaBottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.superiorTopView()
        self.inferiorBottoView()
    }

    func superiorTopView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = telaTopView.bounds
        gradientLayer.colors = [ UIColor(red: 173/255, green: 236/255, blue: 150/255, alpha: 1.0).cgColor,
                                 UIColor(red: 203/255, green: 144/255, blue: 197/255, alpha: 1.0).cgColor]
        telaTopView.layer.addSublayer(gradientLayer)
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
