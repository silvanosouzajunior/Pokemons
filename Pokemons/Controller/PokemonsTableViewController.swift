//
//  PokemonsTableViewController.swift
//  Pokemons
//
//  Created by Silvano Junior on 16/04/18.
//  Copyright © 2018 Silvano. All rights reserved.
//

import UIKit
import LLSpinner

class PokemonsTableViewController: UITableViewController {
    
    let dataManager = DataManager()
    var pokemons = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.delegate = self
        self.setupTabBarController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dataManager.fetchPokemons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PokemonsTableViewController {
    private func setupTabBarController() {
        self.tabBarController?.tabBar.items?.first?.title = "Pokemons";
        self.tabBarController?.tabBar.items?.first?.image = #imageLiteral(resourceName: "pokeball")
        self.tabBarController?.tabBar.items?.last?.title = "Favorites";
        self.tabBarController?.tabBar.items?.last?.image = #imageLiteral(resourceName: "favoriteTab")
    }
    
    private func updateFavoriteCellButton(cell: PokemonTableViewCell, pokemon: Pokemon) {
        if pokemon.isFavorite {
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "star_filled"), for: .normal)
        } else {
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        }
    }
}

extension PokemonsTableViewController: DataManagerDelegate {
    func didUpdatePokemonStats(stats: [String : Int]) {
        LLSpinner.stop()
        self.performSegue(withIdentifier: "ShowPokemonDetails", sender: stats)
    }
    
    func didUpdatePokemons(pokemons: [Pokemon]) {
        self.updateTableWithPokemons(pokemons)
        self.tableView.reloadData()
    }
    
    private func updateTableWithPokemons(_ localPokemons: [Pokemon]) {
        if self.tabBarController?.selectedIndex == 1 {
            self.pokemons = localPokemons.filter({ $0.isFavorite })
        } else {
            self.pokemons = localPokemons
        }
        self.pokemons.sort { $0.url ?? "" < $1.url ?? ""}
    }
}

extension PokemonsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        
        let pokemon = self.pokemons[indexPath.row]
        cell.pokemonName.text = pokemon.name
        self.updateFavoriteCellButton(cell: cell, pokemon: pokemon)
        
        cell.favoriteButtonTapped = { (cell) in
            pokemon.isFavorite = !pokemon.isFavorite
            self.updateFavoriteCellButton(cell: cell, pokemon: pokemon)
        }
        
        return cell
    }
}

extension PokemonsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LLSpinner.spin()
        let pokemon = pokemons[indexPath.row]
        dataManager.fetchPokemonDetails(pokemon: pokemon)
    }
}

extension PokemonsTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPokemonDetails" {
            let destinationViewController = segue.destination as! PokemonDetailsTableViewController
            destinationViewController.pokemonStats = sender as! [String: Int]
        }
    }
}
