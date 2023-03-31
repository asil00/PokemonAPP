//
//  PokemonIdCell.swift
//  PokemonApp
//
//  Created by Asilcan Çetinkaya on 23.03.2023.
//

import UIKit

class PokemonIdCell: UITableViewCell {
    
    @IBOutlet private weak var pokemonImage: UIImageView!
    @IBOutlet private weak var pokemonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(with model: PokemonItem) {
        guard let name = model.pokeName,
              let image = model.pokeUrl
        else { return }
        pokemonName.text = name
        pokemonImage.sd_setImage(with: URL(string: image))
    }
}
