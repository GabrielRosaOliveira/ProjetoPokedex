//
//  FavoritesTexts.swift
//  Pokedex
//
//  Created by Gabriel on 04/01/23.
//

import Foundation

enum FavoritesTexts: String {
    case firebaseCollection = "favorites"
    case pokemonDocument = "pokemon"
    case emailDocument = "email"
    case pokemonStoryboard = "pokemonSelected"
    case pokemonSelectedIdentifier = "pokemonSelectedIdentifier"
    
    //MARK: - FavoritesCollectionViewCell
    
    case favoritesIdentifier = "FavoritesCollectionViewCell"
    
    //MARK: - EmptyCollectionViewCell
    
    case EmptyIdentifier = "EmptyCollectionViewCell"
}
