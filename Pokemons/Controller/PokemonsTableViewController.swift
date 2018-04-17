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
        dataManager.fetchPokemons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PokemonsTableViewController: DataManagerDelegate {
    func didUpdatePokemonStats(stats: [String : Int]) {
        LLSpinner.stop()
        self.performSegue(withIdentifier: "ShowPokemonDetails", sender: stats)
    }
    
    func didUpdatePokemons(pokemons: [Pokemon]) {
        self.pokemons = pokemons
        self.tableView.reloadData()
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
