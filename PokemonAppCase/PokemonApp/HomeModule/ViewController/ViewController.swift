//
//  ViewController.swift
//  PokemonApp
//
//  Created by Asilcan Çetinkaya on 22.03.2023.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController{
    
    //MARK: IBOutlets
    @IBOutlet weak var pokemonTableView: UITableView!
    //MARK: Variables
    private var viewModel: HomeViewModelProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        viewModel.delegate = self
        viewModel.fetchPokemonData()
    }
    
    //MARK: Functions
    override func prepare(for segue: UIStoryboardSegue,sender: Any?)  {
        if segue.identifier == "toDetailVC" {
            if let detailVC = segue.destination as? DetailViewController {
                guard let pokemonName = viewModel.getPokemon(index: sender as! Int)?.pokeName,
                      let pokemonImageUrl = viewModel.getPokemon(index: sender as! Int)?.pokeUrl
                else { return }
                detailVC.config(pokemonName: pokemonName,
                                pokemonImageUrl: pokemonImageUrl)
            }
        }
    }
}

//MARK: Extensions
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPokemonCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonIdCell", for: indexPath) as? PokemonIdCell {
            guard let pokemon = viewModel.getPokemon(index: indexPath.row)
            else { return UITableViewCell() }
            cell.config(with: pokemon)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetailVC", sender: indexPath.row)
    }
}
extension ViewController : HomeViewModelDelegate {
    func pokemonsLoaded() {
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
    }
}
