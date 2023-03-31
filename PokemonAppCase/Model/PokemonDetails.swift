//
//  PokemonDetails.swift
//  PokemonApp
//
//  Created by Asilcan Çetinkaya on 24.03.2023.
//

import Foundation

struct PokemonDetails: Codable {
    
    let sprites: Sprites?
    
}
struct Sprites: Codable {
   
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
       
        case frontDefault = "front_default"
        
    }

}
