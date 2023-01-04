//
//  GenerationOne.swift
//  Pokedex
//
//  Created by Gabriel on 04/01/23.
//

import Foundation

struct GenerationOne: Codable {
    let pokemonSpecies: [PokemonSpecies]
    
    enum CodingKeys: String, CodingKey {
        case pokemonSpecies = "pokemon_species"
    }
    
    struct PokemonSpecies: Codable {
        let name: String
    }
}
