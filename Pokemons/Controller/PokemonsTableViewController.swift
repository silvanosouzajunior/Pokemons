//
//  PokemonsTableViewController.swift
//  Pokemons
//
//  Created by Silvano Junior on 16/04/18.
//  Copyright © 2018 Silvano. All rights reserved.
//

import UIKit

class PokemonsTableViewController: UITableViewController {
    
    var pokemons = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updatePokemonsInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PokemonsTableViewController {
    private func updatePokemonsInfo() {
        DataRequester.getPokemons(completion: { error, result  in
            if let pokemons = result {
                self.pokemons = pokemons
                self.tableView.reloadData()
            }
        })
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
