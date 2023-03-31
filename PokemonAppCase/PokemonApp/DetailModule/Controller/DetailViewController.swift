//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Asilcan Çetinkaya on 29.03.2023.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    //MARK: Variables
    private var pokemonId : Int?
    private var pokemonAbilities : AbilityResult?
    private var pokemonImageUrl : String?
    private var pokemonName : String?
    private var viewModel: DetailViewModelProtocol = DetailViewModel()
    
    //MARK: IBOutlets
    @IBOutlet private weak var pokemonLabelImage: UIImageView!
    @IBOutlet private weak var secondAbilities: UILabel!
    @IBOutlet private weak var firstAbilitiesLabel: UILabel!
    @IBOutlet private weak var abilitiesLabel: UILabel!
    @IBOutlet private weak var detayLabel: UILabel!
    @IBOutlet private weak var detailPokeImage: UIImageView!
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchAbilities(name: self.pokemonName!) { result in
            self.pokemonAbilities = result
            self.firstAbilitiesLabel.text = self.pokemonAbilities?.abilities.first?.ability?.name
            self.secondAbilities.text = self.pokemonAbilities?.abilities[1].ability?.name
            
        }
        self.detayLabel.text = self.pokemonName?.localizedCapitalized
        downloadPokemonImage()
    }
    
    func downloadPokemonImage () {
        detailPokeImage.sd_setImage(with: URL(string: pokemonImageUrl!))
    }
    
    func config(pokemonName: String, pokemonImageUrl: String) {
        self.pokemonName = pokemonName
        self.pokemonImageUrl = pokemonImageUrl
    }
    
}

extension DetailViewController : DetailViewModelDelegate {
    func datasLoaded() {
        print(viewModel)
    }
}
