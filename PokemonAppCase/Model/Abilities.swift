//
//  Abilities.swift
//  PokemonApp
//
//  Created by Asilcan Çetinkaya on 29.03.2023.
//

import Foundation

class AbilityResult : Codable {
    
    let abilities : [Ability]
}

struct Ability: Codable {
    
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Species: Codable {
    let name: String?
    let url: String?
}
