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
        if UIScreen.main.bounds.height < 812.0 {
            tabBar.frame.size.height = 80
            tabBar.frame.origin.y = view.frame.height - 80
        } else {
            tabBar.frame.size.height = 100
            tabBar.frame.origin.y = view.frame.height - 100
        }
    }
    
    func configTabBar() {
        tabBar.layer.cornerRadius = 40
        tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tabBar.layer.borderWidth = 2.5
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.clipsToBounds = true
    }
}
