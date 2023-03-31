//
//  DetailViewModel.swift
//  PokemonApp
//
//  Created by Asilcan Çetinkaya on 29.03.2023.
//

import Foundation
import Alamofire

protocol DetailViewModelProtocol {
    
    //MARK: Variables
    var delegate : DetailViewModelDelegate? { get set }
    //MARK: Functions
    func fetchAbilities(name: String, completion: @escaping(AbilityResult) -> Void)
}

protocol DetailViewModelDelegate: AnyObject {
    //MARK: Functions
    func datasLoaded()
}

final class DetailViewModel : DetailViewModelProtocol {
    var delegate: DetailViewModelDelegate?
    var abilities : AbilityResult?
    
    func fetchAbilities(name : String , completion : @escaping(AbilityResult) -> Void) {
        let baseUrl = "https://pokeapi.co/api/v2/pokemon/\(name)"
        AF.request(baseUrl).responseJSON { response in
            
            guard let data = response.data
            else { return }
            do {
                let decoder = JSONDecoder()
                let abilities = try
                decoder.decode(AbilityResult.self, from: data)
                self.abilities = abilities
                completion(self.abilities!)
                self.delegate?.datasLoaded()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
