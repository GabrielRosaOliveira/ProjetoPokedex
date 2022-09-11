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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

