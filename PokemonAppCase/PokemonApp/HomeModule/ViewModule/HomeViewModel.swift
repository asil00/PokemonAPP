//
//  HomeViewModel.swift
//  PokemonApp
//
//  Created by Asilcan Çetinkaya on 29.03.2023.
//

import Foundation
import Alamofire
import Kingfisher

protocol HomeViewModelProtocol {
    
    //MARK: Variables
    var delegate : HomeViewModelDelegate? {get set}
    var pokemons: [PokemonItem] { get set }
    //MARK: Functions
    func fetchPokemonData()
    func getImageData(item:Result)
    func getPokemonCount() -> Int
    func getPokemon(index : Int) -> PokemonItem?
}

protocol HomeViewModelDelegate : AnyObject {
    func pokemonsLoaded()
}

final class HomeViewModel : HomeViewModelProtocol {
    
    //MARK: Variables
    var delegate: HomeViewModelDelegate?
    var pokemons: [PokemonItem] = []
    
    //MARK: Functions
    func fetchPokemonData() {
        let baseUrl = "https://pokeapi.co/api/v2/pokemon?offset=1&limit=20"
        AF.request(baseUrl).response { response in
            guard let data = response.data
            else { return }
            do {
                let decoder = JSONDecoder()
                let pokemons = try decoder.decode(Pokemon.self, from: data)
                
                for item in pokemons.results ?? [] {
                    self.getImageData(item: item)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getImageData(item: Result) {
        AF.request(item.url ?? "").response { response in
            guard let data = response.data
            else { return }
            do {
                let decoder = JSONDecoder()
                let pokemonItem = try decoder.decode(PokemonDetails.self, from: data)
                self.pokemons.append(PokemonItem(pokeName: item.name, pokeUrl: pokemonItem.sprites?.frontDefault))
                self.delegate?.pokemonsLoaded()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokemonCount() -> Int {
        pokemons.count
    }
    
    func getPokemon(index: Int) -> PokemonItem? {
        pokemons[index]
    }
}
