//
//  GenericService.swift
//  Pokedex
//
//  Created by Gabriel on 28/12/22.
//

import Foundation

protocol GenericService: AnyObject {
    typealias completion <T> = ( _ result: T,  _ failure: Error?) -> Void
}

enum Error: Swift.Error {
    case errorDescription(message: String, error: Swift.Error? = nil)
}
