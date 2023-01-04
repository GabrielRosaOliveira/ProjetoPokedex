//
//  PokemonImageService.swift
//  Pokedex
//
//  Created by Gabriel on 28/12/22.
//

import Foundation

protocol PokemonNameServiceProtocol: GenericService {
    func getPokemonName(completion: @escaping completion<GenerationOne?>)
}

class PokemonNameService: PokemonNameServiceProtocol {
    func getPokemonName(completion: @escaping completion<GenerationOne?>) {
        let pokemonURL: String = "https://pokeapi.co/api/v2/generation/1/"
        
        guard let url: URL = URL(string: pokemonURL) else {
            return completion(nil, Error.errorDescription(message: "ERROR DE URL"))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {
                return completion(nil, Error.errorDescription(message: "Sem data"))
            }
            
            let json = try? JSONSerialization.jsonObject(with: data)
//            print(json as Any)
            
            guard let response = response as? HTTPURLResponse else {
                return completion(nil, Error.errorDescription(message: "Falha na conversao HTTPURLResponse"))
            }
            
            if response.statusCode == 200 {
                do {
                    let decodedData = try JSONDecoder().decode(GenerationOne.self, from: data)
                     completion(decodedData, nil)
                } catch {
                    completion(nil, Error.errorDescription(message: "Deu ruim no parse", error: error))
                    print(error)
                }
            } else {
                completion(nil, Error.errorDescription(message: "Deu ruim", error: error))
            }
        }
        task.resume()
    }
    
    
}
