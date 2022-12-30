//
//  Favorites.swift
//  Pokedex
//
//  Created by Gabriel on 30/12/22.
//

import Foundation
import RealmSwift



class Favorites: Object {
    @objc dynamic var name: String = ""
    let favorites = List<String>()
}
