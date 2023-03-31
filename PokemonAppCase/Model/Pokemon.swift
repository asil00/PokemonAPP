//
//  Pokemon.swift
//  PokemonApp
//
//  Created by Asilcan Çetinkaya on 23.03.2023.
//

import Foundation

struct Pokemon: Codable {
    
    let count: Int?
    let next, previous: String?
    let results: [Result]?
}
