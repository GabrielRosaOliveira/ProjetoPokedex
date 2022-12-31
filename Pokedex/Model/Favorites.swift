//
//  Favorites.swift
//  Pokedex
//
//  Created by Gabriel on 30/12/22.
//

import Foundation
import RealmSwift

class Favorites2: Object {
    let favorites = List<FavoritePokemon2>()
}

class FavoritePokemon2: Object {
    @objc dynamic var name: String = ""
}
