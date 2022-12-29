//
//  PokemonNames.swift
//  Pokedex
//
//  Created by Gabriel on 29/12/22.
//

import Foundation

// MARK: - PokemonNames
struct PokemonNames: Codable {
    let abilities: [JSONAny]
    let id: Int
    let mainRegion: MainRegion
    let moves: [MainRegion]
    let name: String
    let names: [Name]
    let pokemonSpecies, types, versionGroups: [MainRegion]

    enum CodingKeys: String, CodingKey {
        case abilities, id
        case mainRegion = "main_region"
        case moves, name, names
        case pokemonSpecies = "pokemon_species"
        case types
        case versionGroups = "version_groups"
    }
}

// MARK: - MainRegion
struct MainRegion: Codable {
    let name: String
    let url: String
}

// MARK: - Name
struct Name: Codable {
    let language: MainRegion
    let name: String
}
