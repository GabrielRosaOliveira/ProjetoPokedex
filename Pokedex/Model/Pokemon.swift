//
//  Model.swift
//  Pokedex
//
//  Created by Gabriel on 28/12/22.
//

import Foundation

// MARK: - Pokemon
struct Pokemon: Codable {
    var count: Int?
    var next: String?
    var results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    var name: String?
    var url: String?
}

struct PokemonDetail: Decodable {
    
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
    let stats: [PokemonStat]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case weight
        case sprites
        case stats
        
    }
    
}

struct PokemonSprites: Decodable {
    /// URL of the front image of pokemon
    let homeImageURL: String

    enum ContainerKeys: String, CodingKey {
        case other
    }

    enum OtherKeys: String, CodingKey {
        case home
    }

    enum HomeKeys: String, CodingKey {
        case frontImageURL = "front_default"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerKeys.self)
        let otherContainer = try container.nestedContainer(keyedBy: OtherKeys.self, forKey: .other)
        let homeContainer = try otherContainer.nestedContainer(keyedBy: HomeKeys.self, forKey: .home)

        self.homeImageURL = try homeContainer.decode(String.self, forKey: .frontImageURL)
    }
}

struct PokemonStat: Decodable {
    /// name of the statistics
    let name: String

    /// value of the statistics
    let value: Int

    enum ContainerKeys: String, CodingKey {
        case value = "base_stat"
        case stat
    }

    enum StatKeys: String, CodingKey {
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerKeys.self)
        let statContainer = try container.nestedContainer(keyedBy: StatKeys.self, forKey: .stat)

        self.name = try statContainer.decode(String.self, forKey: .name)
        self.value = try container.decode(Int.self, forKey: .value)
    }

}
