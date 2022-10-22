//
//  CALayer+Extension.swift
//  Pokedex
//
//  Created by Felipe Almeida on 11/09/22.
//

import Foundation
import UIKit

extension CALayer {

    func makeShadow(color: UIColor,
                    x: CGFloat      = 0,
                    y: CGFloat      = 0,
                    blur: CGFloat   = 0,
                    spread: CGFloat = 0) {
        shadowColor     = color.cgColor
        shadowOpacity   = 1
        masksToBounds   = false
        shadowOffset    = CGSize(width: x, height: y)
        shadowRadius    = blur / 2
        if spread == 0 {
            shadowPath = nil
        }
        else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
